︠3bf7a6f7-d1f2-4400-9752-152d5999bc1f︠
import numpy
# Implements a coordinate descent LASSO algorithm.
def lasso(X, Y, lambda_val, convergence_val):
    colMeanX = X.mean(0)
    colMeanY = Y.mean(0)
    centeredX = X - colMeanX
    centeredY = Y - colMeanY

    n = centeredX.shape[0] # Number of testing examples.
    d = centeredX.shape[1] # Number of testing features.
    w = numpy.zeros(d) # Initial coefficient vector (set to all zeros).

    hasConverged = False

    while not hasConverged:
        w_old = w
        for i in range(d):
            a_j = 2 * sum(numpy.square(centeredX[:, i]))
            c_j = 2 * (sum(centeredX[:, i].dot((centeredY[:, 0] - centeredX.dot(w) + w[i] * centeredX[:, i]))))

            if c_j < -lambda_val:
                w[i] = (c_j + lambda_val) / a_j
            elif c_j > lambda_val:
                w[i] = (c_j - lambda_val) / a_j
            else:
                w[i] = 0

        if max(abs(w - w_old)) <= convergence_val:
            hasConverged = True
            res = numpy.append(numpy.array(numpy.mean(Y) - sum(colMeanX * w)), w)
    return res

# Does a 10-folds cross validation running a LASSO algorithm.
# Requires the data to have a multiple of 10 number of data points.
def crossVal(data, lambda_val, tolerance):
    k = 10
    N = data.shape[0]
    testSize = N / k
    trainSize = N - testSize

    wSum = numpy.zeros(data.shape[1] - 1)
    yError = numpy.zeros(k)

    # Iterate k times.
    for i in range(k):
        # Find the partitions.
        front = testSize * i
        end = front + testSize

        # Set the training data.
        trainMatrix = numpy.delete(data, range(front, end), 0)
        trainX = numpy.delete(trainMatrix, range(trainMatrix.shape[1] - 2, trainMatrix.shape[1]), 1)
        trainY = numpy.delete(trainMatrix, range(0, trainMatrix.shape[1] - 1), 1)

        # Set the testing data.
        testMatrix = data[front:end, :]
        testX = numpy.column_stack((numpy.ones(testSize), numpy.delete(testMatrix, range(testMatrix.shape[1] - 2, testMatrix.shape[1]), 1)))
        testY = numpy.delete(testMatrix, range(0, testMatrix.shape[1] - 1), 1)

        # Run the LASSO algorithm and compute the squared error.
        w = lasso(trainX, trainY, lambda_val, tolerance)
        wSum = wSum + w
        testW = testX.dot(w)
        diffW = testY[:, 0] - testW
        yError[i] = (k / N) * sum(diffW ^ 2)

    res = ((wSum / k), numpy.mean(yError))
    return res


︡e0fe07cf-c2b1-44d4-871e-28133ce8f46c︡
︠1c8558e4-2185-4466-9e4d-2022762eb178︠
# Load in the data.
traindata = numpy.loadtxt("t1.txt", skiprows=1)

# Run the algorithm on different values of lambda and tolerance.
lambdas = numpy.array([0, 1000, 5000, 10000, 25000, 50000, 100000, 250000, 500000, 1000000])
error_01 = numpy.zeros(lambdas.shape[0])
for index, lam in enumerate(lambdas):
    # Collect the k-folds error for each trial.
    error_01[index] = crossVal(traindata, lam, 0.01)[1]

error_001 = numpy.zeros(lambdas.shape[0])
for index, lam in enumerate(lambdas):
    # Collect the k-folds error for each trial.
    error_001[index] = crossVal(traindata, lam, 0.001)[1]

error_0001 = numpy.zeros(lambdas.shape[0])
for index, lam in enumerate(lambdas):
    # Collect the k-folds error for each trial.
    error_0001[index] = crossVal(traindata, lam, 0.001)[1]
︡6409142f-7c50-44c9-9abb-fd29ce41a0f7︡
︠bf54f678-c231-4c8c-8305-e3f66bd5a376i︠
%hide
line(zip(lambdas, error_001), marker="o")
%md
#### Here is a graph of the lambda regularization constant vs the k-folds error for a convergence tolerance of 0.001.
︡12989482-bf04-4308-b094-5a8624e89438︡{"file":{"show":true,"uuid":"7bc2f4d0-01ed-4339-8f59-dbdbc1a08305","filename":"/mnt/home/f5OLwKD4/.sage/temp/compute1a/19031/tmp_CDYSok.png"}}︡{"stdout":"\n"}︡{"html":"<h4>Here is a graph of the lambda regularization constant vs the k-folds error for a convergence tolerance of 0.001.</h4>\n"}︡
︠f34d1338-7da3-4821-a639-77d37d9be5b7i︠
%hide
header = [""]
for i in lambdas:
    header.append("lambda = " + str(i))

table([header, numpy.append("Error", error_01), numpy.append("Error", error_001), numpy.append("Error", error_0001)], frame=True)
%md
#### Here is a table of the k-folds error (rounded to the nearest thousandths place).
︡15f91f4a-5a53-4c3d-b8d4-e9395e34a5df︡{"stdout":"+-------+------------+---------------+---------------+----------------+----------------+----------------+-----------------+-----------------+-----------------+------------------+\n|       | lambda = 0 | lambda = 1000 | lambda = 5000 | lambda = 10000 | lambda = 25000 | lambda = 50000 | lambda = 100000 | lambda = 250000 | lambda = 500000 | lambda = 1000000 |\n+-------+------------+---------------+---------------+----------------+----------------+----------------+-----------------+-----------------+-----------------+------------------+\n| Error | 0.007      | 0.008         | 0.008         | 0.008          | 0.008          | 0.008          | 0.008           | 0.008           | 0.008           | 0.008            |\n+-------+------------+---------------+---------------+----------------+----------------+----------------+-----------------+-----------------+-----------------+------------------+\n| Error | 0.007      | 0.008         | 0.008         | 0.008          | 0.008          | 0.008          | 0.008           | 0.008           | 0.008           | 0.008            |\n+-------+------------+---------------+---------------+----------------+----------------+----------------+-----------------+-----------------+-----------------+------------------+\n| Error | 0.007      | 0.008         | 0.008         | 0.008          | 0.008          | 0.008          | 0.008           | 0.008           | 0.008           | 0.008            |\n+-------+------------+---------------+---------------+----------------+----------------+----------------+-----------------+-----------------+-----------------+------------------+\n"}︡{"html":"<h4>Here is a table of the k-folds error (rounded to the nearest thousandths place).</h4>\n"}︡
︠fb2e25fc-3955-448f-832b-5250ecd36c15i︠
%hide
timeit('crossVal(traindata, 0, 0.001)')
timeit('crossVal(traindata, 10000, 0.001)')
timeit('crossVal(traindata, 1000000, 0.001)')
%md
#### The run time decreases as we increase the regularization constant since we get sparser solutions.
These trials are run with 0, 10000, and 1000000 valued lambdas respectively.
︡4fd69700-2a7c-4a6c-bb02-a39b7ef1dc0a︡{"stdout":"5 loops, best of 3: 553 ms per loop"}︡{"stdout":"\n5 loops, best of 3: 500 ms per loop"}︡{"stdout":"\n5 loops, best of 3: 476 ms per loop"}︡{"stdout":"\n"}︡{"html":"<h4>The run time decreases as we increase the regularization constant since we get sparser solutions.</h4>\n\n<p>These trials are run with 0, 10000, and 1000000 valued lambdas respectively.</p>\n"}︡
︠494142a9-ef2c-4e27-af64-9d6c81763f29i︠
%hide
res = crossVal(traindata, 10000, 0.001); res[0]
%md
#### Here is a resulting weight vector for lambda = 10000 and a tolerance of 0.001.
Note that the first value is the intercept of the linear model.
︡7f13062d-b3fa-4ee5-b01c-e96de4039b7b︡{"stdout":"array([  4.64833309e-01,   1.52888140e-04,   2.95922534e-07,\n         1.95722569e-05,   2.20427770e-04,   0.00000000e+00,\n         0.00000000e+00,   0.00000000e+00,   0.00000000e+00,\n         0.00000000e+00,   0.00000000e+00,   0.00000000e+00,\n         0.00000000e+00,  -1.24429675e-05,   0.00000000e+00,\n         0.00000000e+00,   0.00000000e+00,   0.00000000e+00,\n         0.00000000e+00])"}︡{"stdout":"\n"}︡{"html":"<h4>Here is a resulting weight vector for lambda = 10000 and a tolerance of 0.001.</h4>\n\n<p>Note that the first value is the intercept of the linear model.</p>\n"}︡
︠2e41f2d2-9a34-4419-8b30-a8acd7c8c4ee︠

