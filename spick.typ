#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart

#set text(font: "Noto Sans")

#set table(stroke: none, inset: 10pt)

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

#page(columns: 2, flipped: true, "a3")[

= Wahrscheinlichkeitsverteilungen

== Stetig/Kontinuierlich

=== Gleichverteilung

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
    $F(x) := cases(
      0 & x < a,
      frac(x - a, b - a) quad & x in [a, b],
      1 & x > b
    )$,
    $phi(x) := cases(
      0 & x < a,
      frac(1, b - a) quad & x in [a, b],
      0 & x > b
    )$,
)

#table(
    columns: (auto, auto, auto),
    $E(X) = frac(a+b, 2)$,
    $"var"(X) = frac((b-a)^2, 12)$,
    $"Median" = frac(a + b, 2)$
)


=== Exponentialverteilung

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
    $F(x) := cases(
      0 & x < 0,
      1-e^(-a x) quad & x in x >= 0,
    )$,
    $phi(x) := cases(
      0 & x < 0,
      a  e^(-a x) quad & x >= 0,
    )$,
)

#table(
    columns: (auto, auto, auto),
    $E(X) = frac(1, a)$,
    $"var"(X) = 1/a^2$,
    $"Median" = t_(1/2) = "ln"(2) / a$
)

=== (Standard-)Normalverteilung

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
    $F(x) "nicht berechenbar"$,
    $phi(x) := frac(1, sqrt(2 pi) sigma) e^(-frac((x-mu)^2, 2 sigma^2))$,
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

- Potenzverteilung

== Diskret

- Binomialverteilung
- Hypergeometrische Verteilung
- Poisson-Verteilung
- Erlang-Verteilung
]
