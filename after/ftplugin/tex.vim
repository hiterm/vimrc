" インデントの深さ
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" mappings
inoremap [tex] <Nop>
imap     `     [tex]

inoremap <buffer> [tex]a \alpha
inoremap <buffer> [tex]b \beta
inoremap <buffer> [tex]c \chi
inoremap <buffer> [tex]d \delta
inoremap <buffer> [tex]e \epsilon
inoremap <buffer> [tex]f \phi
inoremap <buffer> [tex]g \gamma
inoremap <buffer> [tex]h \eta
inoremap <buffer> [tex]i \int_{}^{}<Esc>F}i
inoremap <buffer> [tex]k \kappa
inoremap <buffer> [tex]l \lambda
inoremap <buffer> [tex]m \mu
inoremap <buffer> [tex]n \nu
inoremap <buffer> [tex]o \omega
inoremap <buffer> [tex]p \pi
inoremap <buffer> [tex]q \theta
inoremap <buffer> [tex]r \rho
inoremap <buffer> [tex]s \sigma
inoremap <buffer> [tex]t \tau
inoremap <buffer> [tex]u \upsilon
inoremap <buffer> [tex]v \vee
inoremap <buffer> [tex]w \wedge
inoremap <buffer> [tex]x \xi
inoremap <buffer> [tex]y \psi
inoremap <buffer> [tex]z \zeta
inoremap <buffer> [tex]D \Delta
inoremap <buffer> [tex]I \int_{}^{}<Esc>F}i
inoremap <buffer> [tex]F \Phi
inoremap <buffer> [tex]G \Gamma
inoremap <buffer> [tex]L \Lambda
inoremap <buffer> [tex]N \nabla
inoremap <buffer> [tex]O \Omega
inoremap <buffer> [tex]Q \Theta
inoremap <buffer> [tex]R \varrho
inoremap <buffer> [tex]S \sum_{}^{}<Esc>F}i
inoremap <buffer> [tex]U \Upsilon
inoremap <buffer> [tex]X \Xi
inoremap <buffer> [tex]Y \Psi
inoremap <buffer> [tex]0 \emptyset
inoremap <buffer> [tex]1 \left
inoremap <buffer> [tex]2 \right
inoremap <buffer> [tex]3 \Big
inoremap <buffer> [tex]6 \partial
inoremap <buffer> [tex]8 \infty
inoremap <buffer> [tex]/ \frac{}{}<Esc>F}i
inoremap <buffer> [tex]% \frac{}{}<Esc>F}i
inoremap <buffer> [tex]@ \circ
inoremap <buffer> [tex]\| \Big\|
inoremap <buffer> [tex]= \equiv
inoremap <buffer> [tex]\ \setminus
inoremap <buffer> [tex]. \cdot
inoremap <buffer> [tex]* \times
inoremap <buffer> [tex]& \wedge
inoremap <buffer> [tex]- \bigcap
inoremap <buffer> [tex]+ \bigcup
inoremap <buffer> [tex]( \subset
inoremap <buffer> [tex]) \supset
inoremap <buffer> [tex]< \leq
inoremap <buffer> [tex]> \geq
inoremap <buffer> [tex], \nonumber
inoremap <buffer> [tex]: \dots
inoremap <buffer> [tex]~ \tilde{}<Left>
inoremap <buffer> [tex]^ \hat{}<Left>
inoremap <buffer> [tex]; \dot{}<Left>
inoremap <buffer> [tex]_ \bar{}<Left>
inoremap <buffer> [tex]<M-c> \cos
inoremap <buffer> [tex]<C-E> \exp\left(\right)<Esc>F(a
inoremap <buffer> [tex]<C-I> \in
inoremap <buffer> [tex]<C-J> \downarrow
inoremap <buffer> [tex]<C-L> \log
inoremap <buffer> [tex]<C-P> \uparrow
inoremap <buffer> [tex]<Up> \uparrow
inoremap <buffer> [tex]<C-N> \downarrow
inoremap <buffer> [tex]<Down> \downarrow
inoremap <buffer> [tex]<C-F> \to
inoremap <buffer> [tex]<Right> \lim_{}<Left>
inoremap <buffer> [tex]<C-S> \sin
inoremap <buffer> [tex]<C-T> \tan
inoremap <buffer> [tex]<M-l> \ell
inoremap <buffer> [tex]<CR> \nonumber\\<CR><HOME>&&<Left>

" other letters
inoremap <buffer> [tex]-> \rightarrow
inoremap <buffer> [tex]--> \longrightarrow
inoremap <buffer> [tex]=> \Rightarrow
inoremap <buffer> [tex]==> \Longrightarrow
inoremap <buffer> [tex]<= \Leftarrow
inoremap <buffer> [tex]<=> \Leftrightarrow
inoremap <buffer> [tex]<==> \Longleftrightarrow
