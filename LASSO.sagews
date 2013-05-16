︠3bf7a6f7-d1f2-4400-9752-152d5999bc1f︠
import numpy
# Implements a coordinate descent LASSO algorithm.
def lasso(X, Y, lambda_val, convergence_val, soft_treshold = True):
    colMeanX = X.mean(0)
    colMeanY = Y.mean(0)
    centeredX = X - colMeanX
    centeredY = Y - colMeanY

    n = centeredX.shape[0] # Number of testing examples.
    d = centeredX.shape[1] # Number of testing features.
    w = numpy.zeros(d) # Initial coefficient vector (set to all zeros).

    hasConverged = False

    while not hasConverged:
        for i in range(d):
            a_j = 2 * sum(numpy.square(centeredX[:, i]))
            c_j = 2 * (sum(centeredX[:, i].dot((centeredY - centeredX.dot(w) + w[i].dot(centeredX[:, i])))))


︡cf76de2f-0752-41af-ae94-9a4790899d09︡
︠ecfdfea1-62be-4f91-ae73-bcfcacf61fd5︠
import numpy
a = numpy.array([[1,2,3],[4,5,6]]); a
︡3cb0cbdc-0cb9-4a20-8f08-f0add8da3444︡{"stdout":"array([[1, 2, 3],\n       [4, 5, 6]])\n"}︡
︠2889db62-0457-4d35-a030-b0f8667764f0︠

︠3573af66-b30f-406f-9e44-0687636a706b︠
b = a.mean(0); b
︡947e1f08-761d-455e-8f70-ed2e4e8ed4fe︡{"stdout":"array([ 2.5,  3.5,  4.5])\n"}︡
︠cfef3926-57d6-4f1f-9ea4-327466d7b4b2︠
c = a - b;c
︡5684b9e4-240d-4c49-8dee-ecfcd112f279︡{"stdout":"array([[-1.5, -1.5, -1.5],\n       [ 1.5,  1.5,  1.5]])\n"}︡
︠1816cc2d-95b2-49a6-a7cd-c633705a371e︠
c.shape[1]
︡32642bd9-a3b9-4d1b-82f6-172d1fee03a5︡{"stdout":"3\n"}︡
︠b38bb095-90c8-43fc-8e05-c1023d68baf8︠
z = numpy.zeros(3)
︡8875701f-f6b9-4573-99d6-a51de9a16f4f︡
︠fe008376-c527-4f38-a0cc-de323b61b105︠
︠abbe4066-7138-4d6e-87d3-4250bd721a0c︠
2*sum(numpy.square(a[:,1]))
︡71f477e6-2748-40e1-bedd-9c07dade3bf5︡{"stdout":"58\n"}︡
︠6c1a7a89-8ce6-4cbc-bde0-e7699a6d09e3︠
d = numpy.array([[1,1],[1,1],[1,1]]);d
︡7c0259b0-e464-4f16-8bdd-7b5517109fb4︡{"stdout":"array([[1, 1],\n       [1, 1],\n       [1, 1]])\n"}︡
︠1f766e3d-4fbc-4675-9c66-8abea15159a1︠
a.dot(d)

︡6383778a-8c23-474f-81f8-dfff8707b031︡{"stdout":"array([[ 6,  6],\n       [15, 15]])\n"}︡
︠d068c7a2-82a5-493f-841e-97a0d01fbfc5︠
a.dot(z)
︡02af6ef6-5be4-4a4f-b08b-647a7b7cbb19︡{"stdout":"array([ 0.,  0.])\n"}︡
︠f50270cb-a717-4665-9ad6-3af54fa3f3de︠
z[3]
︡a2a8d94d-222e-4a37-8734-00550e351540︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/mnt/home/f5OLwKD4/.sagemathcloud/sage_server.py\", line 412, in execute\n    exec compile(block, '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\nIndexError: index out of bounds\n"}︡
︠4c7c3a41-0489-467b-931f-d60a93491e80︠

