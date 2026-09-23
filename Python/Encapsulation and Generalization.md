Encapsulation and Generalization

Let’s take the square-drawing code from the previous section and put it in a function called square:

def square():
    for i in range(4):
        forward(50)
        left(90)

Now we can call the function like this:

make_turtle()
square()

Wrapping a piece of code up in a function is called encapsulation. One of the benefits of encapsulation is that it attaches a name to the code, which serves as a kind of documentation. Another advantage is that if you re-use the code, it is more concise to call a function twice than to copy and paste the body!

In the current version, the size of the square is always 50. If we want to draw squares with different sizes, we can take the length of the sides as a parameter:
def square(length):
    for i in range(4):
        forward(length)
        left(90)

Now we can draw squares with different sizes:

make_turtle()
square(30)
square(60)
        
Adding a parameter to a function is called generalization because it makes the function more general: with the previous version, the square is always the same size; with this version it can be any size.

If we add another parameter, we can make it even more general. The following function draws regular polygons with a given number of sides:

def polygon(n, length):
    angle = 360 / n
    for i in range(n):
        forward(length)
        left(angle)
        
In a regular polygon with n sides, the angle between adjacent sides is 360 / n degrees.

The following example draws a 7-sided polygon with side length of 30:

make_turtle()
polygon(7, 30)

When a function has more than a few numeric arguments, it is easy to forget what they are, or what order they should be in. It can be a good idea to include the names of the parameters in the argument list:

make_turtle()
polygon(n=7, length=30)
        
These are sometimes called “named arguments” because they include the parameter names. But in Python they are more often called keyword arguments (not to be confused with Python keywords like for and def).

This use of the assignment operator, =, is a reminder about how arguments and parameters work—when you call a function, the arguments are assigned to the parameters.

Approximating a Circle
Now suppose we want to draw a circle. We can do that, approximately, by drawing a polygon with a large number of sides, so each side is small enough that it’s hard to see. Here is a function that uses polygon to draw a 30-sided polygon that approximates a circle:

import math

def circle(radius):
    circumference = 2 * math.pi * radius
    n = 30
    length = circumference / n
    polygon(n, length)
        
circle takes the radius of the circle as a parameter. It computes circumference, which is the circumference of a circle with the given radius. n is the number of sides, so circumference / n is the length of each side.

This function might take a long time to run. We can speed it up by calling m⁠a⁠k⁠e⁠_​t⁠u⁠r⁠t⁠l⁠e with a keyword argument called delay that sets the time, in seconds, the turtle waits after each step. The default value is 0.2 seconds—if we set it to 0.02 it runs about 10 times faster.

make_turtle(delay=0.02)
circle(30)
        

A limitation of this solution is that n is a constant, which means that for very big circles, the sides are too long, and for small circles, we waste time drawing very short sides. One option is to generalize the function by taking n as a parameter. But let’s keep it simple for now.
