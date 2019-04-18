# test-tardis

This repo contains a quick Haskell exercise using the [tardis][tardis] package.

I wanted to see if using the Tardis monad to reduce the number of passes in a
data structure would reduce the runtime. It doesn't seem like it does, but
maybe my usage of HashMap slows it down.

## Usage

```bash
stack build --test --bench
```

## Results

```
benchmarking Naive/100       
time                 11.37 μs   (11.23 μs .. 11.59 μs)
                     0.998 R²   (0.996 R² .. 0.999 R²)
mean                 11.63 μs   (11.42 μs .. 11.95 μs)
std dev              880.3 ns   (558.2 ns .. 1.222 μs)
variance introduced by outliers: 78% (severely inflated)
                             
benchmarking Naive/1000      
time                 130.2 μs   (106.3 μs .. 159.0 μs)
                     0.829 R²   (0.790 R² .. 0.923 R²)
mean                 116.4 μs   (106.3 μs .. 131.8 μs)
std dev              38.79 μs   (27.36 μs .. 54.79 μs)
variance introduced by outliers: 98% (severely inflated)
                             
benchmarking Naive/10000     
time                 1.082 ms   (971.2 μs .. 1.273 ms)
                     0.773 R²   (0.661 R² .. 0.922 R²)
mean                 1.128 ms   (1.021 ms .. 1.303 ms)
std dev              425.7 μs   (288.7 μs .. 711.8 μs)
variance introduced by outliers: 98% (severely inflated)
                             
benchmarking TardisManual/100
time                 23.20 μs   (19.85 μs .. 29.78 μs)
                     0.639 R²   (0.497 R² .. 0.867 R²)
mean                 32.88 μs   (27.11 μs .. 46.75 μs)
std dev              29.19 μs   (11.82 μs .. 57.96 μs)
variance introduced by outliers: 99% (severely inflated)
                             
benchmarking TardisManual/1000
time                 247.7 μs   (235.9 μs .. 262.4 μs)
                     0.986 R²   (0.979 R² .. 0.995 R²)
mean                 239.3 μs   (234.6 μs .. 246.5 μs)
std dev              18.86 μs   (12.95 μs .. 25.41 μs)
variance introduced by outliers: 70% (severely inflated)
                             
benchmarking TardisManual/10000
time                 8.297 ms   (7.439 ms .. 9.581 ms)
                     0.901 R²   (0.845 R² .. 0.978 R²)
mean                 7.937 ms   (7.601 ms .. 8.554 ms)
std dev              1.271 ms   (855.4 μs .. 1.894 ms)
variance introduced by outliers: 78% (severely inflated)
                             
benchmarking Tardis/100      
time                 31.28 μs   (30.51 μs .. 32.19 μs)
                     0.996 R²   (0.993 R² .. 0.999 R²)
mean                 30.71 μs   (30.43 μs .. 31.27 μs)
std dev              1.300 μs   (780.8 ns .. 2.029 μs)
variance introduced by outliers: 48% (moderately inflated)
                             
benchmarking Tardis/1000     
time                 570.4 μs   (545.1 μs .. 606.3 μs)
                     0.987 R²   (0.975 R² .. 0.999 R²)
mean                 556.1 μs   (549.7 μs .. 575.4 μs)
std dev              31.39 μs   (16.35 μs .. 62.91 μs)
variance introduced by outliers: 50% (moderately inflated)
                             
benchmarking Tardis/10000    
time                 22.13 ms   (21.39 ms .. 23.11 ms)
                     0.996 R²   (0.992 R² .. 1.000 R²)
mean                 21.59 ms   (21.38 ms .. 21.91 ms)
std dev              587.0 μs   (336.0 μs .. 910.3 μs)
```

[tardis]: https://www.stackage.org/lts-13.17/package/tardis-0.4.1.0
