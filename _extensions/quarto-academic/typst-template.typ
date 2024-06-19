#import "@preview/fontawesome:0.2.0": *

// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let color-link = rgb("#483d8b")

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  keywords: none,
  jel-codes: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  sansfont: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  show heading: it => [
    #set text(font: sansfont)
    #block(smallcaps(it.body))
  ]


  if date != none {
    align(left)[#block()[
      #text(weight: "bold", font: sansfont, size: 0.7em)[
        #date
      ]
    ]]
  }

  
  if title != none {
    align(left)[#block(spacing: 4em)[
      #text(weight: "bold", size: 1.5em, font: sansfont)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(left)[
            #text(size: 1.2em, font: sansfont)[#author.name]
            #text(size: 0.85em, fill: rgb("a6ce39"))[
              #if author.orcid != [] {
                link("https://orcid.org/" + author.orcid.text)[#fa-orcid()]
              }
            ] \
            #text(size: 0.85em, font: sansfont)[#author.affiliation] \
            #text(size: 0.7em, font: sansfont, fill: color-link)[
              #link("mailto:" + author.email.children.map(email => email.text).join())[#author.email]
            ]
          ]
      )
    )
  }  

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "bold", font: sansfont, size: 0.9em)[ABASTRACT] #h(0.5em)
      #text(font: sansfont)[#abstract]
      #if keywords != none {
         text(weight: "bold", font: sansfont, size: 0.9em)[\ Keywords:]
         h(0.5em)
         text(font: sansfont)[#keywords]
      }
      #if jel-codes != none {
         text(weight: "bold", font: sansfont, size: 0.9em)[\ JEL-codes:]
         h(0.5em)
         text(font: sansfont)[#jel-codes]
      }
    ]
  }  

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
