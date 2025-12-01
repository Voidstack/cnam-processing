// CNAM - MUX101 - P. Cubaud
// calcul des coef. transformee de Fourier

float[] u = {0,0.262,0.524,0.786,1.047,1.309,0,-1.309,-1.047,-0.786,-0.524,-0.262};
//float[] u = {2.714,3.042,2.134,1.273,0.788,0.495,0.370,0.540,0.191,-0.357,-0.437,0.767};
int  N = 12;
int R = 6;
float a,b,c;

a = 0;
for (int k=0;k<N;k++) {
 a += u[k];
}
a *= 1.0/N;
println("a0 : "+a);

for (int i=1;i<R;i++) {
 a = 0;
 for (int k=0;k<N;k++){
  a += u[k]*cos(2.0*PI*i*k/N);
 }
 a *= 2.0/N;
 b = 0;
 for (int k=0;k<N;k++){
  b += u[k]*sin(2.0*PI*i*k/N);
 }
 b *= 2.0/N;
 c = sqrt(a*a + b*b);
 println( i+" : "+a+" "+b+" "+c);
}