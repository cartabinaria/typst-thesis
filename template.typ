#import "@preview/big-todo:0.2.0": *
#import "@preview/cetz:0.2.2"
#import "@preview/codly:1.0.0": *
#import "@preview/drafting:0.2.0": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import "@preview/wrap-it:0.1.0": wrap-content
#import "@preview/lovelace:0.2.0": *
#import "i18n.typ": *

#let project(
  title: [],
  subtitle: [],
  author: [],
  professors: (),
  department: [],
  course: [],
  session: [],
  academic_year: [],
  abstract: [],
  dedication: [],
  final: false,
  locale: "it",
  bibliography_file: "./bibliography.bib",
  body,
) = {
  set document(author: author, title: title)

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 1.25cm),
    numbering: none,
  )

  set text(
    font: "Libertinus Serif",
    lang: locale,
    region: locale,
    size: 12pt,
    hyphenate: true,
  )

  set page(header: if not final {
    box(
      width: 100%,
      stroke: 1pt + red,
      inset: .5em,
      align(
        center + horizon,
        text(
          fill: red,
          size: 18pt,
          [
            #i18n.at(locale).draft_dated
            #datetime.today().display(i18n.at(locale).date_format)
          ]
        ),
      ),
    )
  } else {
    none
  })

  for logo in ("assets/logo_bw.png", "assets/logo_colored.png") {
    align(
      center,
      [
        #image(logo, width: 6.5cm)
        #v(2em, weak: true)

        #upper[#text(department)]
        #v(2em, weak: true)

        #text(size: 14pt, strong([#text(course)]))
        #line(stroke: (dash: "dotted", thickness: 1pt), length: 100%)
        #v(5em)

        #heading(level: 1, outlined: false, text(size: 28pt, hyphenate: false, title))
        #v(2em)
        #heading(level: 2, outlined: false, text(size: 18pt, weight: "regular", hyphenate: false, subtitle))

        #align(bottom)[
          #text(size: 14pt)[
            #grid(
              columns: (auto, 1fr, auto),
              align: (top + left),
              rows: 1,
              row-gutter: 2em,
              [
                *#text(i18n.at(locale).supervisor):* \
                #text(professors.at(0), hyphenate: false)
              ],
              { },
              [
                *#text(i18n.at(locale).presented_by):* \
                #text(author)
              ],
              {
                if professors.len() > 1 {
                  let title = if professors.len() == 2 {
                    i18n.at(locale).assistant_supervisor
                  } else {
                    i18n.at(locale).assistant_supervisors
                  }
                  text(size: 14pt, weight: "bold", title)
                  linebreak()
                  for professor in professors.slice(1) {
                    text(professor, hyphenate: false)
                    linebreak()
                  }
                }
              },
            )

            #v(2em, weak: true)

            #line(stroke: (dash: "solid", thickness: 1pt), length: 100%)

            #i18n.at(locale).graduation_session_of #text(session) \
            #i18n.at(locale).academic_year #text(academic_year)
          ]
        ]
      ],
    )

    pagebreak()
  }

  set page(margin: 2.5cm)
  show link: underline

  set par(justify: true, leading: 0.75em)

  show raw.where(block: false): box.with(
    stroke: (paint: gray, thickness: .5pt),
    outset: (y: .2em, x: -.2em),
    inset: (x: .5em),
    radius: .2em,
  )

  counter(page).update(1) // reset page counter

  set par(spacing: 1.6em)
  show heading: set block(spacing: 1em)

  if abstract != [] {
    align(
      horizon,
      {
        heading(level: 1, i18n.at(locale).abstract)
        text(abstract)
      },
    )
    pagebreak()
  }

  if dedication != [] and final {
    align(horizon + end, text(dedication))
    pagebreak()
  }

  set page(numbering: "1")

  outline(title: i18n.at(locale).table_of_contents, indent: 20pt, depth: 2)

  {
    show heading.where(level: 1): it => {
      pagebreak()
      v(8cm)
      set par(justify: false, spacing: 0cm)
      let c = counter(heading).display("1")
      // text(size: 40pt, c)
      v(1cm)
      text(size: 40pt, it.body, hyphenate: false)
      v(1cm)
    }

    show heading.where(level: 2): it => {
      set text(size: 20pt)
      v(2cm)
      it
    }

    show heading.where(level: 3): it => {
      set text(size: 14pt)
      it
    }

    set heading(numbering: "1.1.")

    set-page-properties()

    show: codly-init.with()

    codly(
      number-format: none,
      zebra-fill: none,
      languages: (
        python: (name: "Python", icon: "", color: rgb("#3572A5")),
      ),
    )

    show: setup-lovelace

    body

    bibliography(
      bibliography_file,
      title: i18n.at(locale).bibliography,
      style: "institute-of-electrical-and-electronics-engineers",
      // style: "association-for-computing-machinery",
    )
  }
}
