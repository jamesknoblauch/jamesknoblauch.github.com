Charge and Current
##################

:date: 2013-03-17 2:44
:tags: circuits, electricity, physics, math, engineering, eecs
:category: Electric Circuits
:slug: charge-and-current
:author: James Knoblauch
:summary: Notes on electric charge and current.
:latex:


Definitions
============

**Electric charge**, :math:`q`, is a physical property of matter that causes it to 
experience a force when near other electrically charged matter.  Charge is measured 
in `coulombs` (C).

**Elementary charge**, :math:`e`, is the charge of a single electron,

.. math::

    e = -1.602 \times 10^{-19} C


**Electric current**, :math:`i`, is the rate of change of charge, with respect to 
time, measured in `amperes` (A).

**Direct current** (DC) is a current that remains constant with time, 
so :math:`\frac{di}{dt} = 0`.

**Alternating current** (AC) is a current that changes sinusoidally with time, 
so :math:`\frac{di}{dt} \neq 0`.


Mathematical Relationship
==========================

For current :math:`i` and charge :math:`q`,

.. math::

    i = \frac{dq}{dt}


:math:`Q` is the total charge transferred from time :math:`t_{0}` to :math:`t`.

.. math::

    Q = \int_{t_{0}}^{t}{i} dt


Units
======

.. math::

    1A = 1\frac{C}{s}
