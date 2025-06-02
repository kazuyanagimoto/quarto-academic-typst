#import "@preview/fontawesome:0.5.0": *

#let article(
  // Document metadata
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: "ABSTRACT",
  // Custom document metadata
  header: none,
  code-repo: none,
  keywords: none,
  custom-keywords: none,
  thanks: none,
  // Layout settings
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  // Typography settings
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  sansfont: "libertinus sans",
  mathfont: "New Computer Modern Math",
  link-color: rgb("#483d8b"),
  // Structure settings
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  cols: 1,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
  )
  set par(justify: true)
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )
  show math.equation: set text(font: mathfont)
  set heading(numbering: sectionnumbering)
  show heading: set text(font: sansfont, weight: "semibold")

  show figure.caption: it => context [
    #set text(font: sansfont, size: 0.9em)
    #if it.supplement == [Figure] {
      set align(left)
      text(weight: "semibold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    } else {
      text(weight: "semibold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    }

  ]

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el == none {
      it
    } else if el.func() == eq {
      link(el.location())[
        #numbering(
          el.numbering,
          ..counter(eq).at(el.location()),
        )
      ]
    } else if el.func() == figure {
      el.supplement.text
      link(el.location())[
        #set text(fill: link-color)
        #numbering(el.numbering, ..el.counter.at(el.location()))
      ]
    } else {
      it
    }
  }

  show link: set text(fill: link-color)
  set bibliography(title: "References")

  if date != none {
    align(left)[#block()[
        #text(weight: "semibold", font: sansfont, size: 0.8em)[
          #date
          #if header != none {
            h(3em)
            text(weight: "regular")[#header]
          }
        ]
      ]]
  }

  if code-repo != none {
    align(left)[#block()[
        #text(weight: "regular", font: sansfont, size: 0.8em)[
          #code-repo
        ]
      ]]
  }

  if title != none {
    align(left)[#block(spacing: 4em)[
        #text(weight: "semibold", size: 1.5em, font: sansfont)[
          #title
          #if thanks != none {
            footnote(numbering: "*", thanks)
          }\
          #if subtitle != none {
            text(weight: "regular", style: "italic", size: 0.8em)[#subtitle]
          }
        ]
      ]]
  }
  
  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author => align(left)[
        #text(size: 1.2em, font: sansfont)[#author.name]
        #if author.orcid != [] {
          link("https://orcid.org/" + author.orcid.text)[
            #set text(size: 0.85em, fill: rgb("a6ce39"))
            #fa-orcid()
          ]
        } \
        #text(size: 0.85em, font: sansfont)[#author.affiliation] \
        #text(size: 0.7em, font: sansfont, fill: link-color)[
          #link("mailto:" + author.email.children.map(email => email.text).join())[#author.email]
        ]
      ])
    )
  }

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold", font: sansfont, size: 0.9em)[#abstract-title] #h(0.5em)
      #text(font: sansfont)[#abstract]
      #if keywords != none {
        text(weight: "semibold", font: sansfont, size: 0.9em)[\ Keywords:]
        h(0.5em)
        text(font: sansfont)[#keywords]
      }
      #if custom-keywords != none {
        for it in custom-keywords {
          text(weight: "semibold", font: sansfont, size: 0.9em)[\ #it.name:]
          h(0.5em)
          text(font: sansfont)[#it.values]
        }
      }
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
      #outline(
        title: auto,
        depth: none,
      );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#let appendix(content) = {
  // Reset Numbering
  set heading(numbering: "A.1.1")
  counter(heading).update(0)
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)

  // Figure & Table Numbering
  set figure(
    numbering: it => {
      [A.#it]
    },
  )

  // Appendix Start
  pagebreak(weak: true)
  text(size: 2em)[Appendix]
  content
}
