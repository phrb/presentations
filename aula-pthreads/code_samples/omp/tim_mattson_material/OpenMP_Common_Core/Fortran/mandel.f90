!C  PROGRAM: Mandelbrot area
!C
!C  PURPOSE: Program to compute the area of a  Mandelbrot set.
!C           Correct answer should be around 1.510659.
!C           WARNING: this program may contain errors
!C
!C  USAGE:   Program runs without input ... just run the executable
!C            
!C  HISTORY: Written:  (Mark Bull, August 2011).
!C           Changed "comples" to "d_comples" to avoid collsion with 
!C           math.h complex type (Tim Mattson, September 2011)


       MODULE  mandel_module
       implicit none

       INTEGER, PARAMETER :: DP = SELECTED_REAL_KIND(14)

          REAL(KIND = DP) :: r

       INTEGER, PARAMETER :: NPOINTS=1000
       INTEGER, PARAMETER :: MAXITER=1000
       INTEGER :: numoutside=0

       TYPE d_complex
          REAL(KIND = DP) :: r
          REAL(KIND = DP) :: i
       END TYPE d_complex

       TYPE(d_complex) :: c

       contains 

          SUBROUTINE testpoint()

!C Does the iteration z=z*z+c, until |z| > 2 when point is known to be outside set
!C If loop count reaches MAXITER, point is considered to be inside the set

          TYPE(d_complex) :: z
          INTEGER :: iter
          REAL(KIND = DP) :: temp

          z = c

          DO iter = 1, MAXITER
             temp = (z%r*z%r)-(z%i*z%i)+c%r
             z%i = z%r*z%i*2+c%i
             z%r = temp

             IF ((z%r*z%r+z%i*z%i)>4.0) THEN 
                numoutside = numoutside + 1
                EXIT
             ENDIF
          ENDDO

          END SUBROUTINE

       END MODULE mandel_module

       PROGRAM MAIN
       USE OMP_LIB
       USE mandel_module
       IMPLICIT NONE

       INTEGER :: i, j
       REAL(KIND = DP) :: area, error
       REAL(KIND = DP) :: eps = 1.0e-5

!C   Loop over grid of points in the complex plane which contains the Mandelbrot set,
!C   testing each point to see whether it is inside or outside the set.

!$OMP PARALLEL DO DEFAULT(shared) PRIVATE(eps)

       DO i = 1, NPOINTS
       DO j = 1, NPOINTS
          c%r = -2.0+2.5*DBLE(i-1)/DBLE(NPOINTS)+eps
          c%i = 1.125*DBLE(j-1)/DBLE(NPOINTS)+eps
          CALL testpoint()
       ENDDO
       ENDDO
!$OMP END PARALLEL DO

!C Calculate area of set and error estimate and output the results
   
       area = 2.0*2.5*1.125*DBLE(NPOINTS*NPOINTS-numoutside)   &
     &        /DBLE(NPOINTS*NPOINTS)
       error = area/DBLE(NPOINTS)

       write(*,*)"numoutside=", numoutside
       WRITE(*,100) area, error
100    FORMAT("Area of Mandlebrot set = ", f12.8, "  +/-", f12.8)
       WRITE(*,*)"Correct answer should be around 1.510659"

       STOP
       END 
