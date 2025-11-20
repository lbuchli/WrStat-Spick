#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart

#set text(font: "Noto Sans")


#let plot-style = cetz.draw.set-style(
    axes: (
        stroke: none,
        x: (mark: none, padding: 1),
        y: (mark: none),
        tick: (stroke: gray + .5pt),
    ),
    legend: (
        stroke: none,
    ),
)

#let plot-defaults = (
    size: (2, 1.2),
    x-tick-step: none,
    y-tick-step: 0.5,
    x-label: none,
    y-label: none,
)

= Allg. Formelsammlung

== Ableitung
== Integration

== Kombinatorik

== Lineare Regression

== Wahrscheinlichkeit
- Ereignisse
- Bayes
- Totale Wahrscheinlichkeit
- Zentrales Limit-Theorem
- Varianz
- Erwartungswert
- Tschebyscheff-Ungleichung
- Satz von Bernoulli
- Gesetz der grossen Zahlen

= Experimente

- Laplace
- Bernoulli

#page(flipped: true, "a3", margin: 1cm)[

= Wahrscheinlichkeitsverteilungen

#let boxeddistr(title, content) = rect[
    #align(center, pad(6pt)[=== #title])
    #set par(spacing: 0pt)
    #set table(stroke: none, inset: 5pt)
    #content
]

== Stetig/Kontinuierlich


#boxeddistr("Gleichverteilung")[
#table(
    columns: (auto, auto),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            legend: none,
            {
                plot.add(domain: (-2, 2), x =>
                    if x < -1 { 0 }
                    else if x < 0.6 { (x+1)/1.6 }
                    else { 1 }
                )
                plot.add-vline(-1, label: "a")
                plot.add-vline(0.6, label: "b")
                plot.add-vline((-1+0.6)/2, label: "E(X)")
            }
        )
    }),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            fill-below: true,
            {
                plot.add(domain: (-2, 2), x =>
                    if x < -1 { 0 }
                    else if x < 0.6 { 1/1.6 }
                    else { 0 }
                )
                plot.add-vline(-1, label: "a")
                plot.add-vline(0.6, label: "b")
                plot.add-vline((-1+0.6)/2, label: "E(X)")
            }
        )
    }),
    $
    F(x) := cases(
      0 & x < a,
      frac(x - a, b - a) quad & x in [a, b],
      1 & x > b
    )
    $,
    $
    phi(x) := cases(
      0 & x < a,
      frac(1, b - a) quad & x in [a, b],
      0 & x > b
    )
    $,
)

#table(
    columns: (auto, auto, auto),
    $
        E(X) = frac(a+b, 2)
    $,
    $
        "var"(X) = frac((b-a)^2, 12)
    $,
    $
        "Median" = frac(a + b, 2)
    $
)
]


#boxeddistr("Exponentialverteilung")[
#table(
    columns: (auto, auto),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            legend: none,
            {
                plot.add(domain: (-2, 5), x =>
                    if x < 0 { 0 }
                    else {
                        let a = 0.4
                        1-calc.exp(-a*x)
                    }
                )
                plot.add-vline(1/0.4, label: "E(X)")
            }
        )
    }),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            y-tick-step: 0.2,
            fill-below: true,
            {
                plot.add(domain: (-2, 5), x =>
                    if x < 0 { 0 }
                    else {
                        let a = 0.4
                        a*calc.exp(-a*x)
                    }
                )
                plot.add-vline(1/0.4, label: "E(X)")
            }
        )
    }),
    $
    F(x) := cases(
      0 & x < 0,
      1-e^(-a x) quad & x in x >= 0,
      )
    $,
    $
    phi(x) := cases(
      0 & x < 0,
      a  e^(-a x) quad & x >= 0,
      )
    $,
)

#table(
    columns: (auto, auto, auto),
    $
        E(X) = frac(1, a)
    $,
    $
        "var"(X) = 1/a^2
    $,
    $
        "Median" = t_(1/2) = "ln"(2) / a
    $
)
]

#boxeddistr("(Standard-)Normalverteilung")[
#table(
    columns: (auto, auto),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            x-tick-step: 1,
            y-tick-step: 0.2,
            legend: none,
            {
                plot.add(((0.0, 0.5000), (0.1, 0.5398), (0.2, 0.5793),(0.3, 0.6179),(0.4, 0.6554),(0.5, 0.6915),(0.6, 0.7257),(0.7, 0.7580),(0.8, 0.7881),(0.9, 0.8159),(1.0, 0.8413),(1.1, 0.8643),(1.2, 0.8849),(1.3, 0.9032),(1.4, 0.9192),(1.5, 0.9332),(1.6, 0.9452),(1.7, 0.9554),(1.8, 0.9641),(1.9, 0.9713),(2.0, 0.9772),(2.1, 0.9821),(2.2, 0.9861),(2.3, 0.9893),(2.4, 0.9918),(2.5, 0.9938),(2.6, 0.9953),(2.7, 0.9965),(2.8, 0.9974),(2.9, 0.9981),(3.0, 0.9987)))
            }
        )
    }),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            x-tick-step: 2,
            y-tick-step: 0.1,
            fill-below: true,
            {
                plot.add(domain: (-3, 3), x =>
                1 / (calc.sqrt(2*calc.pi)) * calc.exp(- (x*x) / 2)
                )
            }
        )
    }),
    $
        F(x) "nicht berechenbar"
    $,
    $
        phi(x) := frac(1, sqrt(2 pi) sigma) e^(-frac((x-mu)^2, 2 sigma^2))
    $,
)

#table(
    columns: (auto, auto, auto),
    $E(X) = mu$,
    $"var"(X) = sigma^2$,
    $"Median" = mu$
)

- $mu plus.minus 1 sigma ~> 68%$
- $mu plus.minus 2 sigma ~> 95%$
- $mu plus.minus 3 sigma ~> 99.7%$

Für Standardverteilung: $mu = 0$, $sigma = 1$
]

#boxeddistr("Potenzverteilung")[
#table(
    columns: (auto, auto),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            x-tick-step: 1,
            y-tick-step: 0.5,
            legend: none,
            {
                plot.add(domain: (0, 4), x =>
                if x < 1 { 0 }
                else { 1.5 * (1 / -1.5) * calc.pow(x, -1.5) + (1.5 / 1.5) }
                )
                plot.add-vline(1, label: $x_min$)
                plot.add-vline(1.5/0.5, label: $E(x)$)
            }
        )
    }),
    cetz.canvas({
        plot-style
        plot.plot(
            ..plot-defaults,
            x-tick-step: 1,
            y-tick-step: 1,
            fill-below: true,
            {
                plot.add(domain: (0, 4), x =>
                if x < 1 { 0 }
                else { 1.5 * calc.pow(x, -2.5) }
                )
                plot.add-vline(1, label: $x_min$)
                plot.add-vline(1.5/0.5, label: $E(x)$)
            }
        )
    }),
    $
    F(x)_(|a>1) := cases(
    frac(alpha - 1, x_min^(1 - alpha)) frac(1, 1-alpha) x^(-alpha) quad & x > x_min,
        0 & x <= x_min
        )
    $,
    $
    phi(x)_(|a>1) := cases(
        frac(alpha - 1, x_min^(1 - alpha)) x^(-alpha) quad & x > x_min,
        0 & x <= x_min
        )
    $,
)

#table(
    columns: (auto, auto),
    $E(X)_(|a>2) = frac(alpha - 1, alpha - 2) x_min$,
    $"var"(X)_(|a>3) = (frac(alpha - 1, alpha - 3) - (frac(alpha - 1, alpha - 2))^2) x_min^2$,
    $"Median" = 1 - (frac(x_(1/2), x_min))^(1-alpha)$,
    $x_(1/2) = 2^frac(1, alpha - 1) x_min$
)
]

== Diskret

#boxeddistr("Binomialverteilung")[
#table(
    columns: (auto),
    cetz.canvas({
        plot-style
        chart.columnchart(
            ..plot-defaults,
            y-tick-step: 0.1,
            legend: none,
            (..range(0, 6).map(k => (k, calc.binom(10, k)*calc.pow(0.25, k)*calc.pow(0.75, 10-k))))
        )
    }),
    $
    F(k) := sum_(i=0)^k binom(n, i) p^i (1-p)^(n-i)
    $,
)

#table(
    columns: (auto, auto),
    $E(X) = n p$,
    $"var"(X) = n p (1 - p)$,
)
]

#boxeddistr("Hypergeometrische Verteilung")[
#table(
    columns: (auto),
    cetz.canvas({
        plot-style
        chart.columnchart(
            ..plot-defaults,
            y-tick-step: 0.1,
            legend: none,
            (..range(0, 6).map(k => (k, (calc.binom(7, k) * calc.binom(15-7, 6-k)) / calc.binom(15, 6))))
        )
    }),
    $
    h(k|N;M;n) := frac(binom(M, k) binom(N-M, n-k), binom(N, n))
    $,
)

#table(
    columns: (auto, auto),
    $E(X) = n frac(M, N)$,
    $"var"(X) = n frac(M (N - M) (N - n), N^2 (N - 1))$,
)
]

#boxeddistr("Poisson-Verteilung")[
#table(
    columns: (auto),
    cetz.canvas({
        plot-style
        let lambda = 3
        chart.columnchart(
            ..plot-defaults,
            y-tick-step: 0.1,
            legend: none,
            (..range(0, 6).map(k => (k, (calc.pow(lambda, k) / calc.fact(k)) * calc.exp(-lambda))))
        )
    }),
    $
        P_lambda (k) := frac(lambda^k, k!) e^(-lambda)
    $,
)

#table(
    columns: (auto, auto),
    $E(X) = lambda$,
    $"var"(X) = lambda$,
)
]

#boxeddistr("Erlang-Verteilung")[
#table(
    columns: (auto, auto),
    cetz.canvas({
        plot-style
        let k = 7
        let a = 2
        chart.columnchart(
            ..plot-defaults,
            y-tick-step: 0.2,
            legend: none,
            (..range(1, 7).map(x => (x, 1-calc.exp(-a*x) * range(0, k - 1).map(i => calc.pow(a*x, i) / calc.fact(i)).sum())))
        )
    }),
    cetz.canvas({
        plot-style
        let k = 7
        let a = 2
        chart.columnchart(
            ..plot-defaults,
            y-tick-step: 0.2,
            legend: none,
            (..range(1, 7).map(x => (x, calc.pow(a, k) * (calc.pow(x, k - 1) / calc.fact(k - 1)) * calc.exp(-a * x))))
        )
    }),
    $
    F_(X_1,...,X_k)(x) := cases(
    1-e^(-a x) sum^(k-1)_(i=0) frac((a x)^i, i!) quad & x >= 0,
    0 & x < 0
    )
    $,
    $
    phi_(X_1,...,X_k)(x) := cases(
    a^k frac(x^(k-1), (k-1)!) e^(- a x) quad & x >= 0,
    0 & x < 0
    )
    $,
)
]
]
