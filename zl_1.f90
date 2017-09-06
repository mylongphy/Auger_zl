program main

implicit none

CHARACTER(LEN=80) INFILE, OUTFILE, dum10
integer i, block_n, m, j, k, tran_n, i_n, i_j, f_n, f_j
integer select_n, cut_n, grid_n, p, nele_n
integer level_i(5000), j_i(50000), level_f(50000), j_f(50000)
real  auger_en, auger_ra, str, total, cascade
real energy(50000), rate(50000), strength(50000)


write(*,*)'name of the inputfile'
read(*,*)INFILE
write(*,*)'name of the outputfile'
read(*,*)OUTFILE

write(*,*)'the level of the initial state'
read(*,*)select_n
write(*,*)'the cutoff level for cascade'
read(*,*)cut_n

open (2,file=INFILE, status='old')
open (3,file=OUTFILE, status='unknown')


do i=1,6
read(2,*)
end do

read(2,*)dum10,dum10, block_n
!write (*,*)block_n
total =0.0
m=1

do i=1,block_n

read(2,*)
read(2,*)dum10,dum10,nele_n
read(2,*)dum10,dum10,tran_n
!write(*,*)tran_n

read(2,*)
read(2,*)dum10, dum10, grid_n

do p=1,grid_n

read(2,*)

end do

do k=1,tran_n

read(2,*)i_n,i_j,f_n,f_j,auger_en,auger_ra,str
if (i_n == select_n) then
write(3,*)i_n,i_j,f_n,f_j,auger_en,auger_ra,str
total=total+auger_ra
if (f_n>=cut_n)then

cascade=cascade+auger_ra

end if

end if 

!level_i(m)=i_n
!j_i(m)=i_j
!level_f(m)=f_n
!j_f(m)=f_j
!energy(m)=auger_en
!rate(m)=auger_ra
!strength(m)=str
m=m+1
end do
end do

write(*,*)'total rate is ', total
write(*,*)'witdh is ', 1000*6.58212124E-16*total, 'meV'
write(*,*)'cascade rate is ', cascade
write(*,*)'cascade probability is ', 100*cascade/total,'%'
!do i=1,m-1

!write (*,*)level_i

!end do

end program
