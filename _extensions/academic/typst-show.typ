#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(header)$
  header: [$header$],
$endif$
$if(code-repo)$
  code-repo: [$code-repo$],
$endif$
$if(by-author)$
  authors: (
$for(by-author)$
$if(it.name.literal)$
    ( name: [$it.name.literal$],
      affiliation: [$for(it.affiliations)$$it.name$$sep$, $endfor$],
      email: [$it.email$],
      orcid: [$it.orcid$]
    ),
$endif$
$endfor$
    ),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(keywords)$
  keywords: [$for(keywords)$$keywords$$sep$, $endfor$],
$endif$
$if(custom-keywords)$
  custom-keywords: (
    $for(custom-keywords)$
      ( name: [$it.name$],
        values: [$for(it.values)$$it$$sep$, $endfor$]
      ),
    $endfor$
  ),
$endif$
$if(thanks)$
  thanks: [$thanks$],
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(mainfontoptions)$
  $if(mainfontoptions.number-type)$
    number-type: "$mainfontoptions.number-type$",
  $endif$
  $if(mainfontoptions.number-width)$
    number-width: "$mainfontoptions.number-width$",
  $endif$
$endif$
$if(sansfont)$
  sansfont: ("$sansfont$",),
$endif$
$if(mathfont)$
  mathfont: ("$mathfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
  cols: $if(columns)$$columns$$else$1$endif$,
  doc,
)