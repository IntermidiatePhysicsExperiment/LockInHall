// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  abstract: [],
  authors: (),
  date: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en")
  set text(font: "NanumMyeongjo", lang: "en", size:0.8em)
  
  
  // Configure equation numbering and spacing.
  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(
        it.element.label,
        numbering(
          it.element.numbering,
          ..counter(math.equation).at(it.element.location())
        )
      )
    } else {
      // Other references as usual.
      it
    }
  }

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.25em, title))
    #v(1em, weak: true)
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email \
        _#author.affiliation _
      ]),
    ),
  )
  align(center)[
    #set text(size: 0.75em)
    (Dated: #date)
  ]

  //Configure Captioning
  set figure.caption(separator: ". ")
  show figure.caption: set text(size:0.9em)
  show figure.caption: set align(left)
  show figure.caption: set par(hanging-indent: 0mm)
  // set figure(numbering: "1", supplement: [Fig.])

  //Configure headings
  set heading(numbering: "i")
  show heading: title => locate(loc => {
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }
    set align(center)
    v(3pt)
    
    if title.level == 1 [
      #linebreak()
      #set text(size:0.7em)
      #upper[
        #if (title.body==[Bibliography]) [
          #numbering("I. ", deepest+1)
          #title.body] else [
          #numbering("I. ", deepest)
          #title.body
        ]
      ]
    ]

    if title.level == 2 [
      #set text(size:0.85em)
      #numbering("A. ", deepest)
      #title.body
    ]

    if title.level == 3 [
      #set text(size:1em, weight: "semibold", style: "italic")
      #numbering("1. ", deepest) #title.body
    ]
    
    if title.level == 4 [
      #set align(left)
      #set text(size:0.9em, weight: "semibold")
      #set par(first-line-indent: 0pt)
      #numbering("a. ", deepest) #title.body
    ]
    v(10pt)
  })

  // Ref
  show ref: it => {
    if it.element != none and it.element.func() == heading {
      // Override heading references.
      link(
        it.element.label,
        "Section"+numbering(
          "I-A-1-a",
          ..counter(heading).at(it.element.location())
        )
      )
    } else {
      // Other references as usual.
      it
    }
  }
  
  pad(left:10%, right: 10%)[#text(size:0.9em)[#abstract]]
  
  // Main body.
  set par(justify: true, first-line-indent: 15pt, leading: 0.7em)
  columns(2)[#body]
}