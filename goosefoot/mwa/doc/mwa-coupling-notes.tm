<TeXmacs|1.99.3>

<style|<tuple|generic|british>>

<\body>
  Let <math|\<Omega\>> be the 3D domain and
  <math|\<Phi\>=<around*|[|0,w|]>\<times\><around*|{|0|}>\<times\><around*|[|0,h|]>\<subset\>\<bbb-R\><rsup|2>>
  is a rectangle in the <math|x z> plane, the axisymmetric domain, where
  <math|w> and <math|h> are chosen for a particular needle model.

  <section|Steady State Axisymmetric (Maxwell's + Pennes)>

  <math|\<b-E\>=<around*|(|E<rsub|r>,0,E<rsub|\<phi\>>|)>> is calculated from
  Maxwell's equations (see Sheldon & Phil's notes). Note that this mesh has
  to be <em|very> fine. This uses the temperature dependent
  <math|\<sigma\><rsub|eff>> and <math|\<varepsilon\><rsub|r>>.

  Calculate <math|<wide|Q|^>\<assign\><around*|[|Q/\<sigma\>|]>\|<rsub|\<Phi\>>=<frac|1|2>*<around*|\||\<nabla\>\<b-E\>|\|><rsup|2>>.
  Can be offline.

  <section|Weakly-coupled Pennes><label|eqn-coupled-pennes>

  <math|\<sigma\><around*|(|310|)>> from standard values gives initial
  conductivity.

  <\eqnarray*>
    <tformat|<table|<row|<cell|Q<rsub|ext>>|<cell|=>|<cell|\<sigma\><rsub|eff><around*|(|T|)>*<wide|Q|^><rsub|P,N><around*|(|x|)>>>>>
  </eqnarray*>

  where <math|P>, <math|N> represent the needle power level and
  manufacturer/model. A library can be built up of axisymmetric steady-state
  solutions for these pairs.

  Rest as normal - update <math|\<sigma\><rsub|eff><around*|(|T|)>=exp
  <around*|{|things<around*|(|T|)>|}>>.

  While <reference|eqn-coupled-pennes> is the only step needing to be done at
  run-time, the interpolation of the <math|<wide|Q|^><rsub|P,N>> onto meshes
  must be done with the original 2D mesh.

  <section|Projection>

  Defining <math|<wide|Q|^>> over <math|\<Omega\>>. Let
  <math|x\<in\>\<Omega\>>, then,

  <\eqnarray*>
    <tformat|<table|<row|<cell|<text|Let ><wide|Q|^><rsub|\<Omega\>>>|<cell|:>|<cell|\<Omega\>\<rightarrow\>\<bbb-R\>>>|<row|<cell|<text|We
    load ><wide|Q|^><rsub|\<Phi\>>>|<cell|:>|<cell|\<Phi\>\<rightarrow\>\<bbb-R\><text|
    from the file system.>>>|<row|<cell|<wide|Q|^><rsub|\<Omega\>><around*|(|x|)>>|<cell|\<assign\>>|<cell|<choice|<tformat|<table|<row|<cell|<wide|Q|^><rsub|\<Phi\>><around*|(|\<pi\><around*|(|x|)>|)>,>|<cell|\<pi\><around*|(|x|)>\<in\>\<Phi\>\<subset\>\<bbb-R\><rsup|2>>>|<row|<cell|0>|<cell|otherwise>>>>><text|
    where <math|\<pi\>:\<bbb-R\><rsup|3>\<rightarrow\>\<bbb-R\><rsup|2>> is a
    suitable projection.>>>|<row|<cell|>|<cell|>|<cell|<text|(in other words,
    if <math|\<pi\><around*|(|x|)>> does not lie in the <math|\<Phi\>>
    rectangle it is 0)>>>|<row|<cell|<text|Let
    >\<b-p\>>|<cell|=>|<cell|needle tip>>|<row|<cell|\<b-v\>>|<cell|=>|<cell|needle
    axis unit vector>>|<row|<cell|\<b-w\>>|<cell|is>|<cell|a unit vector
    perpendicular to \<b-v\> <text|(e.g. <math|<around*|(|0,0,1|)>> if not
    <math|<around*|\|||\|><rsup|el>>)>>>|<row|<cell|\<b-u\>>|<cell|=>|<cell|\<b-v\>\<times\>\<b-w\><text|
    creates a plane with <math|\<b-v\>>, which will be mapped to <math|x z>
    plane.>>>|<row|<cell|\<pi\><around*|(|\<b-x\>|)>>|<cell|\<assign\>>|<cell|\<pi\><rsub|1>\<circ\>\<pi\><rsub|2><around*|(|\<b-x\>|)>>>|<row|<cell|\<pi\><rsub|2><around*|(|\<b-x\>|)>>|<cell|\<assign\>>|<cell|\<b-x\>-<around*|(|<around*|(|\<b-x\>-\<b-p\>|)>\<cdot\>\<b-w\>|)>*\<b-w\>
    >>|<row|<cell|>|<cell|>|<cell|<text|this projects the point
    <math|\<b-x\>> onto the <math|\<b-u\>\<b-v\>> plane through the
    needle.>>>>>
  </eqnarray*>

  Let <math|A> be the matrix:

  <\eqnarray*>
    <tformat|<table|<row|<cell|A>|<cell|=>|<cell|<matrix|<tformat|<table|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|\<b-u\><rsup|T>>|<cell|\<b-w\><rsup|T>>|<cell|\<b-v\><rsup|T>>>|<row|<cell|>|<cell|>|<cell|>>>>>>>|<row|<cell|\<pi\><rsub|2><around*|(|\<b-y\>|)>>|<cell|=>|<cell|<around*|[|A<rsup|-1><around*|(|\<b-y\>-\<b-p\>|)>|]>\|<rsub|\<bbb-R\><rsup|2>><text|
    dropping the <math|y> component.>>>>>
  </eqnarray*>

  This maps the <math|\<b-u\>\<b-v\>> plane to the standard <math|x y> plane:
  <math|\<b-p\>> to <math|<around*|(|0,0|)>>, <math|\<b-u\>> to
  <math|<around*|(|1,0|)>>, <math|\<b-v\>> to <math|<around*|(|0,1|)>>.a
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|.TeXmacs/texts/scratch/no_name_11.tm>>
    <associate|auto-2|<tuple|2|?|.TeXmacs/texts/scratch/no_name_11.tm>>
    <associate|auto-3|<tuple|3|?|.TeXmacs/texts/scratch/no_name_11.tm>>
    <associate|eqn-coupled-pennes|<tuple|2|?|.TeXmacs/texts/scratch/no_name_11.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Steady
      State Axisymmetric (Maxwell's + Pennes)>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Weakly-coupled
      Pennes> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Projection>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>