
	.data
V1:	.double	8.0 8.0 9.0 6.0 1.0 2.4 3.0 1.2 0.1 10.0 
V2:	.double	9.0 8.0 7.0 6.0 5.0 0.4 3.0 0.2 0.1 10.0
V3: .double 8.0 8.0 9.0 6.0 1.0 2.4 3.0 1.2 0.1 10.0
V4:	.double 9.0 8.0 7.0 6.0 5.0 0.4 3.0 0.2 0.1 10.0
V5:	.double 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0  

		.text
main:	daddui r1,r0,0 
		daddui r2,r0,10
loop:	l.d  f1,V1(r1)
		l.d  f2,V2(r1)
		mul.d  f5,f1,f2
		l.d  f3,V3(r1)
		l.d  f4,V4(r1)
		div.d f6, f3, f4
		sub.d  f5,f5,f6
		s.d  f5,V5(r1) 
		daddui  r1,r1,8
		daddi  r2,r2,-1
		bnez  r2,loop  
		halt
