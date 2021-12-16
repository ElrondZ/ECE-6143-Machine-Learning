"""
@File Name    :  hw2
@Create On    :  10/1/21 2:55 PM
@Platform     :  PyCharm in MacOS
@Author  :  Zihan Zeng
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat


def sign_fuc(y):
    y[y >= 0] = 1;
    y[y < 0] = -1
    return y


def calculate_error(y, y_pred, N):
    return float(np.count_nonzero(sign_fuc(y_pred) != y)) / N


def calculate_risk(y, y_pred, N):
    assert (y.shape[-1] == 1)
    risk = np.sum(sign_fuc(np.multiply(-y, y_pred)))
    return risk / N


# Load data from data3.mat && Convert data to usable type
matData = loadmat('data3.mat')
_x = matData['data'][:, :2]
y = matData['data'][:, -1:]
x = np.concatenate((_x, np.ones((_x.shape[0], 1))), axis=1)

error_list = []
risk_list = []

max_iteration = 1000
lr = 0.5
iteration = 0

samples_num, features_num = x.shape
weights = np.random.random_sample((features_num, 1))

while iteration < max_iteration:
    i = np.random.randint(samples_num)
    output = x[i].reshape((1, 3)).dot(weights)
    if sign_fuc(np.multiply(y[i], output))[0] == -1:
        weights += lr * x[i].reshape((3, 1)).dot(y[i].reshape((1, 1)))
        y_pred = x.dot(weights)
        error_list.append(calculate_error(y, y_pred, samples_num))
        risk_list.append(calculate_risk(y, y_pred, samples_num))
        print(error_list[iteration], iteration)
        iteration += 1
        if error_list[-1] == 0:
            break

samples_num = x.shape[0]
for i in range(samples_num):
    if y[i] == 1:
        plt.plot(x[i, 0], x[i, 1], 'ro')
    else:
        plt.plot(x[i, 0], x[i, 1], 'yo')
min_x = min(x[:, 0])
max_x = max(x[:, 0])
y_min_x = float(-weights[2] - weights[0] * min_x) / weights[1]
y_max_x = float(-weights[2] - weights[0] * max_x) / weights[1]
plt.plot([min_x, max_x], [y_min_x, y_max_x], 'b')
plt.title('Boundary on the 2D x')
plt.xlabel('X1');
plt.ylabel('X2')
plt.savefig('1.png')
plt.show()


plt.plot(range(iteration), error_list, 'b')
plt.xlabel('iterations')
plt.title('Classification Error')
plt.savefig('2.png')
plt.show()


plt.plot(range(iteration), risk_list, 'y')
plt.xlabel('iterations')
plt.title('Perceptron Error')
plt.savefig('3.png')
plt.show()
