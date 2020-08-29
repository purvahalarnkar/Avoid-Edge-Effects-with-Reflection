# Avoid-Edge-Effects-with-Reflection
There are edge effects at the boundaries of time series anytime you are applying a filter

Edge effects are unavoidable. However, that doesn’t mean that edge effects need to contaminate the entire signal

Reflection is a way of avoiding edge effects contaminating the signal by adding additional versions of the signal to the beginning and the end of the signal

The idea is that the edge effects will contaminate those new edges and then you cut them off

The reason why you get edge effects with filters like FIR is because each time point in the filtered signal is defined to be a weighted combination 
of previous values of the original signal, and for IIR filters, it is a product of weighted values of the previous version of the filtered signal

These filters cannot actually start all the way from time point 1, because the kernel goes backwards in time and there is nothing backwards in time

Therefore, the filtered signal can really only begin at one kernel length into the signal

The way to have the filtered signals start and stop at the boundaries of the original signal is, to apply reflection

If you have relatively short time series, you can simply reflect the entire time series
otherwise you can just reflect the piece of the time series that is as long as the filter kernel (order of the filter)
