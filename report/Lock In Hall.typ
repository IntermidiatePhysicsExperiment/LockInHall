#import "template.typ": *
#import "@preview/tablex:0.0.8": *
#let th=[#math.theta]
#let ll=[#sym.angle.l]
#let rr=[#sym.angle.r]
#let times="×"
#show: project.with(
  title: "Lock In Hall",
  authors: (
    (name: "Seunghyun Moon", email: "shmoon232@snu.ac.kr", affiliation: "Department of Physics and Astronomy, Seoul National University,\nSeoul, 08826 South Korea"),
  ),
  abstract: "asdf"+"\n"+text(weight: "bold")[Keywords: ]
  +"",
  date: "May 22, 2024",
)

= Introduction

= Experimental Method

= Results

= Discussion

= Conclusion

#bibliography("reference.bib", full:true, style: "american-physics-society")
