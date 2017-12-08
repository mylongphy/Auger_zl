       program main
       implicit none


       CHARACTER(LEN=80) FSAFile, SSAFile, Outfile, CASFile
       integer i, j, fc, sc, lev1(1000), k, lev2(1000), levm(1000)
       integer lev3(1000),m, lev4(1000),n, p, caslev(1000)
       real*8 fsau(1000), au, tot, ssau(1000), partial_cas, cas_rate(1000)
       real*8 array(1000,1000), totm(1000),br, partial_cas1(1000), total


       write(*,*)'name of first  single auger input file ?'
       read(*,*)FSAFile
       write(*,*)'name of second single auger input file ?'
       read(*,*)SSAFile
       write(*,*)'name of output file ?'
       read(*,*)OutFile
       write(*,*)'name of the cascade rates for each final state?'
       read(*,*)CASFile
       
       

       open(1,file=FSAFile,status='old')
       open(2,file=SSAFile,status='old')
       open(3,file=Outfile,status='unknown')
       open(4,file=CASFile,status='unknown')
       


! *******read the first single Auger file
       read(1,*)fc      ! the number of the rows in the first single Auger file
       do i=1,fc
            read(1,*)lev1(i), fsau(i)
       end do

! ******sort the second single Auger data, calculated the total rates for each intermediate state
       k=1
       tot = 0.0
       read(2,*)sc !     the number of the rows in the second single Auger file
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



! calculate the cascade rate
        n = 1
       do j=1,k-1
           write(*,*)levm(j), totm(j)
           write (3,*)'===================='
           write(3,*)'the intermediate level=',levm(j)
           write (3,*)'===================='
           do i=1, sc
               if (lev2(i)==levm(j)) then
                   br = ssau(i)/totm(j)   ! the bracnhing ratios
                   do m =1, fc
                       if (lev1(m)==lev2(i)) partial_cas = br*fsau(m)
                   end do
                   lev4(n) = lev3(i)
                   partial_cas1(n) = partial_cas ! the cascade rate for each intermediate state
                   n =n+1
                   write(3,*)levm(j), lev3(i), br, partial_cas
               endif
           enddo
       enddo



! sum up the cascade rate of each intermediate states to get the total cascade rates of the each final state
      p = 1
      do i = 1, sc
          if (lev2(i) == levm(k-1)) then
          caslev(p) = lev3(i)
          p = p +1
          endif
      enddo

!       do i = 1, n-1
!       write(*,*)lev4(i), partial_cas1(i)
!       enddo

       
       do j = 1, p-1
           total = 0.0
!           write(*,*)caslev(j)
           do i = 1, n-1
               if (lev4(i) == caslev(j)) then 
                   total = total + partial_cas1(i)
               endif
           enddo
           cas_rate(j) = total
           write(4,*)caslev(j), cas_rate(j)
       enddo
       end
