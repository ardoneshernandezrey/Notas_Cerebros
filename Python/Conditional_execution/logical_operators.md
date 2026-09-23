Logical Operators

There are three **logical operators: and, or,** and **not**. The semantics (meaning) of these operators is similar
to their meaning in English. For example, 

x > 0 and x < 10

is true only if x is greater than 0 **and** less than 10. 

n%2 == 0 or n%3 == = is true if either of the condictions is true, that is, if the number is divisible by 2 **or** 3.

Finally, the **not** operator negates a boolean expression, so **not** (x > y) is true if x > y is false.

>>> x = 1
>>> y = 2
>>> x > y
False
>>> not (x > y)
True 


