from flask import Flask, render_template, request
import numpy as np
from scipy import integrate, optimize
app = Flask(__name__)

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/lab1")
def lab1():
    # A = np.array([
    #   [2, 2, -3, -1],
    #   [1, 3, 3, -7],
    #   [2, -1, -1, 3],
    #   [3, 2, 2, -4]
    # ])
    # b = np.array([0, 0, 0, 0])
    equations_number = request.args.get('equations_number', type = int)
    b = request.args.getlist('b', type=int)
    A = np.array(request.args.getlist('a', type=int)).reshape(len(b), len(b))
    x = np.array([])
    if len(b) > 0:
        x = np.linalg.solve(A, b)
        # n = len(les)
        # tmp = list(zip(*les))
        # b = tmp[-1]
        # del tmp[-1]

        # delta = det(tmp)
        # if not delta:
        #     raise RuntimeError("Решения нет")

        # result = []
        # for i in range(n):
        #     a = tmp[:]
        #     a[i] = b
        #     result.append(det(a) / delta)
    return render_template('lab1.html', equations_number=equations_number, A=A, b=b, x=x)


def trapezoidal(f, a, b, n):
    """
    Вычисляет приближенное значение интеграла с помощью формулы трапеций
    f - подынтегральная функция
    a, b - пределы интегрирования
    n - количество частичных отрезков
    """
    h = float(b - a)/n
    result = 0.5*(f(a) + f(b))
    for i in range(1, n):
        result += f(a + i*h)
    result *= h
    return result

def midpoint_riemann_sum(f, a, b, n):
    h = (b-a)/float(n)
    total = sum([f((a + (k*h))) for k in range(0, n)])
    result = h * total
    return result

@app.route("/lab2")
def lab2():
    # f = lambda x: x * 3**(-x)
    f = lambda x: x * np.arctan(x)
    # a = 0
    # b = 1

    a = request.args.get('a', type=float)
    b = request.args.get('b', type=float)
    n = request.args.get('n', type=int)
    print(n)

    x = None
    if a != None and b != None and n != None:
        # x = trapezoidal(f, a, b, n)
        x = midpoint_riemann_sum(f, a, b, n)
        # x, _err = integrate.quad(f, a, b)

    return render_template('lab2.html', a=a, b=b, x=x)


@app.route("/lab3")
def lab3():
    # f = lambda x, y: x**2 + y**2
    f = lambda x, y: x**2 + 3*x*y
    # x_start = -2
    # x_end = 2
    # x0 = 0
    # y0 = [0.3]

    x_start = request.args.get('x_start', type=float)
    x_end = request.args.get('x_end', type=float)
    x0 = request.args.get('x0', type=float)
    y0 = request.args.getlist('y0', type=float)

    xs = ys = np.array([])
    if x_start != None and x_end != None and x0 != None and y0 != None:
        solution = integrate.solve_ivp(f, (x_start, x_end), y0, max_step=0.1, min_step=0.1)
        ys = solution.y[0]
        xs = solution.t

    return render_template('lab3.html', x0=x0, y0=y0 , xs=xs, ys=ys)


# Функция Розенброка
def Rosenbrock(x):
    return x[0]**2 + x[1]**2 + x[2]**2 - x[0]*x[1] + x[0] - 2*x[2]

@app.route("/lab4")
def lab4():
    n = 3
    # Начальная точка поиска минимума функции
    x0 = request.args.getlist('x0', type=float)
    # x0 = np.array([2.0, 2.0, 2.0])
    # xtol = 1.0e-10 # Точность поиска экстремума
    xtol = request.args.get('precision', type=float)
    # Находим минимум функции
    res = None
    if len(x0) > 0:
        res = optimize.minimize(Rosenbrock, x0, method = 'Nelder-Mead', options = {'xtol': xtol, 'disp': True})

    return render_template('lab4.html', x0=x0, res=res)
