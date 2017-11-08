       program main
       implicit none


       CHARACTER(LEN=80) FSAFile, SSAFile, Outfile
       integer i, j, fc, sc, lev1(1000), k, lev2(1000), levm(1000)
       integer lev3(1000),m
       real*8 fsau(1000), au, tot, ssau(1000), partial_cas
       real*8 array(1000,1000), totm(1000),br


       write(*,*)'name of first  single aguer input file ?'
       read(*,*)FSAFile
       write(*,*)'name of second single auger input file ?'
       read(*,*)SSAFile
       write(*,*)'name of output file ?'
       read(*,*)OutFile
       
       

       open(1,file=FSAFile,status='old')
       open(2,file=SSAFile,status='old')
       open(3,file=Outfile,status='unknown')
       



       read(1,*)fc
       do i=1,fc
            read(1,*)lev1(i), fsau(i)
       end do
       k=1
       tot = 0.0
       read(2,*)sc
!       read(2,*)lev2(1), lev3(1), ssau(1)
           do i = 1, sc+1
               if (i.le.sc) read(2,*)lev2(i), lev3(i), ssau(i)

               if (i==1.OR.lev2(i)==lev2(i-1)) then
                  tot = tot + ssau(i)
               else
                  totm(k) = tot
                  levm(k) = lev2(i-1)
                  tot = ssau(i)
!                  write(*,*)totm
                  k = k + 1
             endif
           end do

        
       do j=1,k-1
           write(*,*)levm(j), totm(j)
           write (3,*)'===================='
           write(3,*)'the intermediate level=',levm(j)
           write (3,*)'===================='
           do i=1, sc
               if (lev2(i)==levm(j)) then
                   br = ssau(i)/totm(j)
                   do m =1, fc
                       if (lev1(m)==lev2(i)) partial_cas = br*fsau(m)
                   end do
                   write(3,*)levm(j), lev3(i), br, partial_cas
               endif
           enddo
       enddo



        end
