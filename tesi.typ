#import "template.typ": *
#import "@preview/codly:1.0.0": *

#show: project.with(
  title: [
    #lorem(5)
  ],
  author: "Pippo Baudo",
  professors: (
    "Prof. Lupo Lucio",
    "Prof. Gatto Silvestro",
    "Dott. Paperino"
  ),
  department: "Dipartimento della Televisione dei Ragazzi",
  course: "Laurea in Scienze dell'Albero Azzurro",
  session: "di Luglio",
  aa: "2000/2001",
  abstract: [
    #lorem(100)
  ],
  dedication: [ 
    A quella puntata della Melevisione interrotta a metà.
  ],
  final: true,
)

= Introduzione

#lorem(100)

== Sotto-paragrafo 1

#lorem(100) @miur

=== Sotto-sotto-paragrafo 1

```swift
let x = 1

if x == 1 {
  print("Hello, world!")
}
```






