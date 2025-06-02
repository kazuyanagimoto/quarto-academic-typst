#show: doc => article(
// Document metadata
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
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
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(abstract-title)$
  abstract-title: [$abstract-title$],
$endif$
// Custom document metadata
$if(header)$
  header: [$header$],
$endif$
$if(code-repo)$
  code-repo: [$code-repo$],
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
// Layout settings
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
// Typography settings
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$elseif(brand.typography.base.family)$
  font: $brand.typography.base.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(sansfont)$
  sansfont: ("$sansfont$",),
$elseif(brand.typography.headings.family)$
  sansfont: $brand.typography.headings.family$,
$endif$
$if(mathfont)$
  mathfont: ("$mathfont$",),
$elseif(brand.defaults.academic-typst.mathfont)$
  mathfont: ("$brand.defaults.academic-typst.mathfont$"),
$endif$
$if(brand.typography.link.color)$
  link-color: $brand.typography.link.color$,
$endif$
// Structure settings
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
  cols: $if(columns)$$columns$$else$1$endif$,
  doc,
)