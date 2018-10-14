from flask import Flask, render_template
import numpy as np
from scipy import integrate
app = Flask(__name__)

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/lab1")
def lab1():
    A = np.array([
      [2, 2, -3, -1],
      [1, 3, 3, -7],
      [2, -1, -1, 3],
      [3, 2, 2, -4]
    ])
    b = np.array([0, 0, 0, 0])
    x = np.linalg.solve(A, b)
    return render_template('lab1.html', A=A, b=b, x=x)

@app.route("/lab2")
def lab2():
    f = lambda x: x * np.arctan(x)
    a = 0
    b = 1
    i, err = integrate.quad(f, a, b)
    return render_template('lab2.html', a=a, b=b, i=i)

@app.route("/lab3")
def lab3():
    f = lambda x, y: x**2 + 3*x*y
    x0 = 0
    y0 = [0.3]
    solution = integrate.RK45(f, x0, y0, 1000)
    return render_template('lab3.html', x0=x0, y0=y0, solution=solution)
