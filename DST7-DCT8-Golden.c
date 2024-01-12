#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// DCT-8
#define DEFINE_DCT8_P4_MATRIX(a,b,c,d) \
{ \
  {  a,  b,  c,  d,}, \
  {  b,  0, -b, -b,}, \
  {  c, -b, -d,  a,}, \
  {  d, -b,  a, -c,}, \
}

#define DEFINE_DCT8_P8_MATRIX(a,b,c,d,e,f,g,h) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,}, \
  {  b,  e,  h, -g, -d, -a, -c, -f,}, \
  {  c,  h, -e, -a, -f,  g,  b,  d,}, \
  {  d, -g, -a, -h,  c,  e, -f, -b,}, \
  {  e, -d, -f,  c,  g, -b, -h,  a,}, \
  {  f, -a,  g,  e, -b,  h,  d, -c,}, \
  {  g, -c,  b, -f, -h,  d, -a,  e,}, \
  {  h, -f,  d, -b,  a, -c,  e, -g,}, \
}

#define DEFINE_DCT8_P16_MATRIX(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,  i,  j,  k,  l,  m,  n,  o,  p,}, \
  {  b,  e,  h,  k,  n,  0, -n, -k, -h, -e, -b, -b, -e, -h, -k, -n,}, \
  {  c,  h,  m, -p, -k, -f, -a, -e, -j, -o,  n,  i,  d,  b,  g,  l,}, \
  {  d,  k, -p, -i, -b, -f, -m,  n,  g,  a,  h,  o, -l, -e, -c, -j,}, \
  {  e,  n, -k, -b, -h,  0,  h,  b,  k, -n, -e, -e, -n,  k,  b,  h,}, \
  {  f,  0, -f, -f,  0,  f,  f,  0, -f, -f,  0,  f,  f,  0, -f, -f,}, \
  {  g, -n, -a, -m,  h,  f, -o, -b, -l,  i,  e, -p, -c, -k,  j,  d,}, \
  {  h, -k, -e,  n,  b,  0, -b, -n,  e,  k, -h, -h,  k,  e, -n, -b,}, \
  {  i, -h, -j,  g,  k, -f, -l,  e,  m, -d, -n,  c,  o, -b, -p,  a,}, \
  {  j, -e, -o,  a, -n, -f,  i,  k, -d, -p,  b, -m, -g,  h,  l, -c,}, \
  {  k, -b,  n,  h, -e,  0,  e, -h, -n,  b, -k, -k,  b, -n, -h,  e,}, \
  {  l, -b,  i,  o, -e,  f, -p, -h,  c, -m, -k,  a, -j, -n,  d, -g,}, \
  {  m, -e,  d, -l, -n,  f, -c,  k,  o, -g,  b, -j, -p,  h, -a,  i,}, \
  {  n, -h,  b, -e,  k,  0, -k,  e, -b,  h, -n, -n,  h, -b,  e, -k,}, \
  {  o, -k,  g, -c,  b, -f,  j, -n, -p,  l, -h,  d, -a,  e, -i,  m,}, \
  {  p, -n,  l, -j,  h, -f,  d, -b,  a, -c,  e, -g,  i, -k,  m, -o,}, \
}

#define DEFINE_DCT8_P32_MATRIX(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,  i,  j,  k,  l,  m,  n,  o,  p,  q,  r,  s,  t,  u,  v,  w,  x,  y,  z,  A,  B,  C,  D,  E,  F,}, \
  {  b,  e,  h,  k,  n,  q,  t,  w,  z,  C,  F, -E, -B, -y, -v, -s, -p, -m, -j, -g, -d, -a, -c, -f, -i, -l, -o, -r, -u, -x, -A, -D,}, \
  {  c,  h,  m,  r,  w,  B,  0, -B, -w, -r, -m, -h, -c, -c, -h, -m, -r, -w, -B,  0,  B,  w,  r,  m,  h,  c,  c,  h,  m,  r,  w,  B,}, \
  {  d,  k,  r,  y,  F, -A, -t, -m, -f, -b, -i, -p, -w, -D,  C,  v,  o,  h,  a,  g,  n,  u,  B, -E, -x, -q, -j, -c, -e, -l, -s, -z,}, \
  {  e,  n,  w,  F, -y, -p, -g, -c, -l, -u, -D,  A,  r,  i,  a,  j,  s,  B, -C, -t, -k, -b, -h, -q, -z,  E,  v,  m,  d,  f,  o,  x,}, \
  {  f,  q,  B, -A, -p, -e, -g, -r, -C,  z,  o,  d,  h,  s,  D, -y, -n, -c, -i, -t, -E,  x,  m,  b,  j,  u,  F, -w, -l, -a, -k, -v,}, \
  {  g,  t,  0, -t, -g, -g, -t,  0,  t,  g,  g,  t,  0, -t, -g, -g, -t,  0,  t,  g,  g,  t,  0, -t, -g, -g, -t,  0,  t,  g,  g,  t,}, \
  {  h,  w, -B, -m, -c, -r,  0,  r,  c,  m,  B, -w, -h, -h, -w,  B,  m,  c,  r,  0, -r, -c, -m, -B,  w,  h,  h,  w, -B, -m, -c, -r,}, \
  {  i,  z, -w, -f, -l, -C,  t,  c,  o,  F, -q, -a, -r,  E,  n,  d,  u, -B, -k, -g, -x,  y,  h,  j,  A, -v, -e, -m, -D,  s,  b,  p,}, \
  {  j,  C, -r, -b, -u,  z,  g,  m,  F, -o, -e, -x,  w,  d,  p, -E, -l, -h, -A,  t,  a,  s, -B, -i, -k, -D,  q,  c,  v, -y, -f, -n,}, \
  {  k,  F, -m, -i, -D,  o,  g,  B, -q, -e, -z,  s,  c,  x, -u, -a, -v,  w,  b,  t, -y, -d, -r,  A,  f,  p, -C, -h, -n,  E,  j,  l,}, \
  {  l, -E, -h, -p,  A,  d,  t, -w, -a, -x,  s,  e,  B, -o, -i, -F,  k,  m, -D, -g, -q,  z,  c,  u, -v, -b, -y,  r,  f,  C, -n, -j,}, \
  {  m, -B, -c, -w,  r,  h,  0, -h, -r,  w,  c,  B, -m, -m,  B,  c,  w, -r, -h,  0,  h,  r, -w, -c, -B,  m,  m, -B, -c, -w,  r,  h,}, \
  {  n, -y, -c, -D,  i,  s, -t, -h,  E,  d,  x, -o, -m,  z,  b,  C, -j, -r,  u,  g, -F, -e, -w,  p,  l, -A, -a, -B,  k,  q, -v, -f,}, \
  {  o, -v, -h,  C,  a,  D, -g, -w,  n,  p, -u, -i,  B,  b,  E, -f, -x,  m,  q, -t, -j,  A,  c,  F, -e, -y,  l,  r, -s, -k,  z,  d,}, \
  {  p, -s, -m,  v,  j, -y, -g,  B,  d, -E, -a, -F,  c,  C, -f, -z,  i,  w, -l, -t,  o,  q, -r, -n,  u,  k, -x, -h,  A,  e, -D, -b,}, \
  {  q, -p, -r,  o,  s, -n, -t,  m,  u, -l, -v,  k,  w, -j, -x,  i,  y, -h, -z,  g,  A, -f, -B,  e,  C, -d, -D,  c,  E, -b, -F,  a,}, \
  {  r, -m, -w,  h,  B, -c,  0,  c, -B, -h,  w,  m, -r, -r,  m,  w, -h, -B,  c,  0, -c,  B,  h, -w, -m,  r,  r, -m, -w,  h,  B, -c,}, \
  {  s, -j, -B,  a, -C, -i,  t,  r, -k, -A,  b, -D, -h,  u,  q, -l, -z,  c, -E, -g,  v,  p, -m, -y,  d, -F, -f,  w,  o, -n, -x,  e,}, \
  {  t, -g,  0,  g, -t, -t,  g,  0, -g,  t,  t, -g,  0,  g, -t, -t,  g,  0, -g,  t,  t, -g,  0,  g, -t, -t,  g,  0, -g,  t,  t, -g,}, \
  {  u, -d,  B,  n, -k, -E,  g, -r, -x,  a, -y, -q,  h, -F, -j,  o,  A, -c,  v,  t, -e,  C,  m, -l, -D,  f, -s, -w,  b, -z, -p,  i,}, \
  {  v, -a,  w,  u, -b,  x,  t, -c,  y,  s, -d,  z,  r, -e,  A,  q, -f,  B,  p, -g,  C,  o, -h,  D,  n, -i,  E,  m, -j,  F,  l, -k,}, \
  {  w, -c,  r,  B, -h,  m,  0, -m,  h, -B, -r,  c, -w, -w,  c, -r, -B,  h, -m,  0,  m, -h,  B,  r, -c,  w,  w, -c,  r,  B, -h,  m,}, \
  {  x, -f,  m, -E, -q,  b, -t, -B,  j, -i,  A,  u, -c,  p,  F, -n,  e, -w, -y,  g, -l,  D,  r, -a,  s,  C, -k,  h, -z, -v,  d, -o,}, \
  {  y, -i,  h, -x, -z,  j, -g,  w,  A, -k,  f, -v, -B,  l, -e,  u,  C, -m,  d, -t, -D,  n, -c,  s,  E, -o,  b, -r, -F,  p, -a,  q,}, \
  {  z, -l,  c, -q,  E,  u, -g,  h, -v, -D,  p, -b,  m, -A, -y,  k, -d,  r, -F, -t,  f, -i,  w,  C, -o,  a, -n,  B,  x, -j,  e, -s,}, \
  {  A, -o,  c, -j,  v,  F, -t,  h, -e,  q, -C, -y,  m, -a,  l, -x, -D,  r, -f,  g, -s,  E,  w, -k,  b, -n,  z,  B, -p,  d, -i,  u,}, \
  {  B, -r,  h, -c,  m, -w,  0,  w, -m,  c, -h,  r, -B, -B,  r, -h,  c, -m,  w,  0, -w,  m, -c,  h, -r,  B,  B, -r,  h, -c,  m, -w,}, \
  {  C, -u,  m, -e,  d, -l,  t, -B, -D,  v, -n,  f, -c,  k, -s,  A,  E, -w,  o, -g,  b, -j,  r, -z, -F,  x, -p,  h, -a,  i, -q,  y,}, \
  {  D, -x,  r, -l,  f, -a,  g, -m,  s, -y,  E,  C, -w,  q, -k,  e, -b,  h, -n,  t, -z,  F,  B, -v,  p, -j,  d, -c,  i, -o,  u, -A,}, \
  {  E, -A,  w, -s,  o, -k,  g, -c,  b, -f,  j, -n,  r, -v,  z, -D, -F,  B, -x,  t, -p,  l, -h,  d, -a,  e, -i,  m, -q,  u, -y,  C,}, \
  {  F, -D,  B, -z,  x, -v,  t, -r,  p, -n,  l, -j,  h, -f,  d, -b,  a, -c,  e, -g,  i, -k,  m, -o,  q, -s,  u, -w,  y, -A,  C, -E,}, \
}


// DST-7
#define DEFINE_DST7_P4_MATRIX(a,b,c,d) \
{ \
  {  a,  b,  c,  d }, \
  {  c,  c,  0, -c }, \
  {  d, -a, -c,  b }, \
  {  b, -d,  c, -a }, \
}

#define DEFINE_DST7_P8_MATRIX(a,b,c,d,e,f,g,h) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,}, \
  {  c,  f,  h,  e,  b, -a, -d, -g,}, \
  {  e,  g,  b, -c, -h, -d,  a,  f,}, \
  {  g,  c, -d, -f,  a,  h,  b, -e,}, \
  {  h, -a, -g,  b,  f, -c, -e,  d,}, \
  {  f, -e, -a,  g, -d, -b,  h, -c,}, \
  {  d, -h,  e, -a, -c,  g, -f,  b,}, \
  {  b, -d,  f, -h,  g, -e,  c, -a,}, \
}

#define DEFINE_DST7_P16_MATRIX(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,  i,  j,  k,  l,  m,  n,  o,  p,}, \
  {  c,  f,  i,  l,  o,  o,  l,  i,  f,  c,  0, -c, -f, -i, -l, -o,}, \
  {  e,  j,  o,  m,  h,  c, -b, -g, -l, -p, -k, -f, -a,  d,  i,  n,}, \
  {  g,  n,  l,  e, -b, -i, -p, -j, -c,  d,  k,  o,  h,  a, -f, -m,}, \
  {  i,  o,  f, -c, -l, -l, -c,  f,  o,  i,  0, -i, -o, -f,  c,  l,}, \
  {  k,  k,  0, -k, -k,  0,  k,  k,  0, -k, -k,  0,  k,  k,  0, -k,}, \
  {  m,  g, -f, -n, -a,  l,  h, -e, -o, -b,  k,  i, -d, -p, -c,  j,}, \
  {  o,  c, -l, -f,  i,  i, -f, -l,  c,  o,  0, -o, -c,  l,  f, -i,}, \
  {  p, -a, -o,  b,  n, -c, -m,  d,  l, -e, -k,  f,  j, -g, -i,  h,}, \
  {  n, -e, -i,  j,  d, -o,  a,  m, -f, -h,  k,  c, -p,  b,  l, -g,}, \
  {  l, -i, -c,  o, -f, -f,  o, -c, -i,  l,  0, -l,  i,  c, -o,  f,}, \
  {  j, -m,  c,  g, -p,  f,  d, -n,  i,  a, -k,  l, -b, -h,  o, -e,}, \
  {  h, -p,  i, -a, -g,  o, -j,  b,  f, -n,  k, -c, -e,  m, -l,  d,}, \
  {  f, -l,  o, -i,  c,  c, -i,  o, -l,  f,  0, -f,  l, -o,  i, -c,}, \
  {  d, -h,  l, -p,  m, -i,  e, -a, -c,  g, -k,  o, -n,  j, -f,  b,}, \
  {  b, -d,  f, -h,  j, -l,  n, -p,  o, -m,  k, -i,  g, -e,  c, -a,}, \
}

#define DEFINE_DST7_P32_MATRIX(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F) \
{ \
  {  a,  b,  c,  d,  e,  f,  g,  h,  i,  j,  k,  l,  m,  n,  o,  p,  q,  r,  s,  t,  u,  v,  w,  x,  y,  z,  A,  B,  C,  D,  E,  F,}, \
  {  c,  f,  i,  l,  o,  r,  u,  x,  A,  D,  F,  C,  z,  w,  t,  q,  n,  k,  h,  e,  b, -a, -d, -g, -j, -m, -p, -s, -v, -y, -B, -E,}, \
  {  e,  j,  o,  t,  y,  D,  D,  y,  t,  o,  j,  e,  0, -e, -j, -o, -t, -y, -D, -D, -y, -t, -o, -j, -e,  0,  e,  j,  o,  t,  y,  D,}, \
  {  g,  n,  u,  B,  D,  w,  p,  i,  b, -e, -l, -s, -z, -F, -y, -r, -k, -d,  c,  j,  q,  x,  E,  A,  t,  m,  f, -a, -h, -o, -v, -C,}, \
  {  i,  r,  A,  C,  t,  k,  b, -g, -p, -y, -E, -v, -m, -d,  e,  n,  w,  F,  x,  o,  f, -c, -l, -u, -D, -z, -q, -h,  a,  j,  s,  B,}, \
  {  k,  v,  F,  u,  j, -a, -l, -w, -E, -t, -i,  b,  m,  x,  D,  s,  h, -c, -n, -y, -C, -r, -g,  d,  o,  z,  B,  q,  f, -e, -p, -A,}, \
  {  m,  z,  z,  m,  0, -m, -z, -z, -m,  0,  m,  z,  z,  m,  0, -m, -z, -z, -m,  0,  m,  z,  z,  m,  0, -m, -z, -z, -m,  0,  m,  z,}, \
  {  o,  D,  t,  e, -j, -y, -y, -j,  e,  t,  D,  o,  0, -o, -D, -t, -e,  j,  y,  y,  j, -e, -t, -D, -o,  0,  o,  D,  t,  e, -j, -y,}, \
  {  q,  E,  n, -c, -t, -B, -k,  f,  w,  y,  h, -i, -z, -v, -e,  l,  C,  s,  b, -o, -F, -p,  a,  r,  D,  m, -d, -u, -A, -j,  g,  x,}, \
  {  s,  A,  h, -k, -D, -p,  c,  v,  x,  e, -n, -F, -m,  f,  y,  u,  b, -q, -C, -j,  i,  B,  r, -a, -t, -z, -g,  l,  E,  o, -d, -w,}, \
  {  u,  w,  b, -s, -y, -d,  q,  A,  f, -o, -C, -h,  m,  E,  j, -k, -F, -l,  i,  D,  n, -g, -B, -p,  e,  z,  r, -c, -x, -t,  a,  v,}, \
  {  w,  s, -d, -A, -o,  h,  E,  k, -l, -D, -g,  p,  z,  c, -t, -v,  a,  x,  r, -e, -B, -n,  i,  F,  j, -m, -C, -f,  q,  y,  b, -u,}, \
  {  y,  o, -j, -D, -e,  t,  t, -e, -D, -j,  o,  y,  0, -y, -o,  j,  D,  e, -t, -t,  e,  D,  j, -o, -y,  0,  y,  o, -j, -D, -e,  t,}, \
  {  A,  k, -p, -v,  e,  F,  f, -u, -q,  j,  B,  a, -z, -l,  o,  w, -d, -E, -g,  t,  r, -i, -C, -b,  y,  m, -n, -x,  c,  D,  h, -s,}, \
  {  C,  g, -v, -n,  o,  u, -h, -B,  a,  D,  f, -w, -m,  p,  t, -i, -A,  b,  E,  e, -x, -l,  q,  s, -j, -z,  c,  F,  d, -y, -k,  r,}, \
  {  E,  c, -B, -f,  y,  i, -v, -l,  s,  o, -p, -r,  m,  u, -j, -x,  g,  A, -d, -D,  a,  F,  b, -C, -e,  z,  h, -w, -k,  t,  n, -q,}, \
  {  F, -a, -E,  b,  D, -c, -C,  d,  B, -e, -A,  f,  z, -g, -y,  h,  x, -i, -w,  j,  v, -k, -u,  l,  t, -m, -s,  n,  r, -o, -q,  p,}, \
  {  D, -e, -y,  j,  t, -o, -o,  t,  j, -y, -e,  D,  0, -D,  e,  y, -j, -t,  o,  o, -t, -j,  y,  e, -D,  0,  D, -e, -y,  j,  t, -o,}, \
  {  B, -i, -s,  r,  j, -A, -a,  C, -h, -t,  q,  k, -z, -b,  D, -g, -u,  p,  l, -y, -c,  E, -f, -v,  o,  m, -x, -d,  F, -e, -w,  n,}, \
  {  z, -m, -m,  z,  0, -z,  m,  m, -z,  0,  z, -m, -m,  z,  0, -z,  m,  m, -z,  0,  z, -m, -m,  z,  0, -z,  m,  m, -z,  0,  z, -m,}, \
  {  x, -q, -g,  E, -j, -n,  A, -c, -u,  t,  d, -B,  m,  k, -D,  f,  r, -w, -a,  y, -p, -h,  F, -i, -o,  z, -b, -v,  s,  e, -C,  l,}, \
  {  v, -u, -a,  w, -t, -b,  x, -s, -c,  y, -r, -d,  z, -q, -e,  A, -p, -f,  B, -o, -g,  C, -n, -h,  D, -m, -i,  E, -l, -j,  F, -k,}, \
  {  t, -y,  e,  o, -D,  j,  j, -D,  o,  e, -y,  t,  0, -t,  y, -e, -o,  D, -j, -j,  D, -o, -e,  y, -t,  0,  t, -y,  e,  o, -D,  j,}, \
  {  r, -C,  k,  g, -y,  v, -d, -n,  F, -o, -c,  u, -z,  h,  j, -B,  s, -a, -q,  D, -l, -f,  x, -w,  e,  m, -E,  p,  b, -t,  A, -i,}, \
  {  p, -F,  q, -a, -o,  E, -r,  b,  n, -D,  s, -c, -m,  C, -t,  d,  l, -B,  u, -e, -k,  A, -v,  f,  j, -z,  w, -g, -i,  y, -x,  h,}, \
  {  n, -B,  w, -i, -e,  s, -F,  r, -d, -j,  x, -A,  m,  a, -o,  C, -v,  h,  f, -t,  E, -q,  c,  k, -y,  z, -l, -b,  p, -D,  u, -g,}, \
  {  l, -x,  C, -q,  e,  g, -s,  E, -v,  j,  b, -n,  z, -A,  o, -c, -i,  u, -F,  t, -h, -d,  p, -B,  y, -m,  a,  k, -w,  D, -r,  f,}, \
  {  j, -t,  D, -y,  o, -e, -e,  o, -y,  D, -t,  j,  0, -j,  t, -D,  y, -o,  e,  e, -o,  y, -D,  t, -j,  0,  j, -t,  D, -y,  o, -e,}, \
  {  h, -p,  x, -F,  y, -q,  i, -a, -g,  o, -w,  E, -z,  r, -j,  b,  f, -n,  v, -D,  A, -s,  k, -c, -e,  m, -u,  C, -B,  t, -l,  d,}, \
  {  f, -l,  r, -x,  D, -C,  w, -q,  k, -e, -a,  g, -m,  s, -y,  E, -B,  v, -p,  j, -d, -b,  h, -n,  t, -z,  F, -A,  u, -o,  i, -c,}, \
  {  d, -h,  l, -p,  t, -x,  B, -F,  C, -y,  u, -q,  m, -i,  e, -a, -c,  g, -k,  o, -s,  w, -A,  E, -D,  z, -v,  r, -n,  j, -f,  b,}, \
  {  b, -d,  f, -h,  j, -l,  n, -p,  r, -t,  v, -x,  z, -B,  D, -F,  E, -C,  A, -y,  w, -u,  s, -q,  o, -m,  k, -i,  g, -e,  c, -a,}, \
}

//--------------------------------------------------------------------------------------------------

#define MAX 32

// DCT-8
int trCoreDCT8P4[4][MAX] = DEFINE_DCT8_P4_MATRIX(84, 74, 55, 29);
int trCoreDCT8P8[8][MAX] = DEFINE_DCT8_P8_MATRIX(86,     85,     78,     71,     60,     46,     32,     17);
int trCoreDCT8P16[16][MAX] = DEFINE_DCT8_P16_MATRIX(88,     88,     87,     85,     81,     77,     73,     68,     62,     55,     48,     40,     33,     25,     17,      8);
int trCoreDCT8P32[32][MAX] = DEFINE_DCT8_P32_MATRIX(90,     90,     89,     88,     87,     86,     85,     84,     82,     80,     78,     77,     74,     72,     68,     66,     63,     60,     56,     53,     50,     46,     42,     38,     34,     30,     26,     21,     17,     13,      9,      4);

// DST-7
int trCoreDST7P4[4][MAX] = DEFINE_DST7_P4_MATRIX(29,    55,    74,    84);
int trCoreDST7P8[8][MAX] = DEFINE_DST7_P8_MATRIX(17,    32,    46,    60,    71,    78,    85,    86);
int trCoreDST7P16[16][MAX] = DEFINE_DST7_P16_MATRIX(8,    17,    25,    33,    40,    48,    55,    62,    68,    73,    77,    81,    85,    87,    88,    88);
int trCoreDST7P32[32][MAX] = DEFINE_DST7_P32_MATRIX(4,     9,    13,    17,    21,    26,    30,    34,    38,    42,    46,    50,    53,    56,    60,    63,    66,    68,    72,    74,    77,    78,    80,    82,    84,    85,    86,    87,    88,    89,    90,    90);


#define SAMPLES 16
#define INOUTPUTS 64
#define MAXBITS 20

void intToBinary(int n, char* str)
{
    printf("%d\n", n);
    int i, bin[MAXBITS];

    for (i = 0; i < MAXBITS; i++){
        bin[i] = ((unsigned int)n >> i) & 1;
    }

    for(int j = 0, i = MAXBITS - 1; j < MAXBITS; j++, i--){
        str[j] = (char) bin[i] + 48;
    }
}

void generateEntry(FILE* filePointer, int matrix[SAMPLES][INOUTPUTS], int i, int j, int maxBit) {
    char str[MAXBITS + 1];
    //itoa(matrix[i][j], str, 2);
    printf("ENTERING FUNC...\n");
    intToBinary(matrix[i][j], str);
    char newStr[MAXBITS];
    strcpy(newStr, "");

    printf("STR: %s\n", str);
    printf("STR: %d\n", (int) strlen(str));
    //printf("SIZE: %d\n", (strlen(str)));
    if(strlen(str) == maxBit) {
        printf("EQUAL\n");
        strcat(newStr, str);
    } else if (strlen(str) < maxBit) {
        printf("LESS\n");
        for(int i = 0; i < maxBit - strlen(str); i++){
            strcat(newStr, "0");
        }
        strcat(newStr, str);
    } else {
        printf("MORE\n");
        strcat(newStr, str + (strlen(str) - maxBit));
    }

    printf("NEW STR: %s\n", newStr);
    
    strcat(newStr, " ");
    fputs(newStr, filePointer);
}

void generateFile(char* fileName, int matrix[SAMPLES][INOUTPUTS], int maxBit) {
    FILE* filePointer = fopen(fileName,"w");

	for (int i = 0; i < SAMPLES; i++) {
        //printf("%d\n", i);
        for (int j = 0; j < INOUTPUTS; j++) {
            //printf("%d\n", j);
            generateEntry(filePointer, matrix, i, j, maxBit);
        }
        if(i != SAMPLES - 1) fputs("\n", filePointer);
	}

	fclose(filePointer);
}

void generateEntryDec(FILE* filePointer, int matrix[SAMPLES][INOUTPUTS], int i, int j) {
    char str[10];
    sprintf(str, "%d", matrix[i][j]);
    //itoa(matrix[i][j], str, 10);
    strcat(str, " ");
    fputs(str, filePointer);
}

void generateFileDec(char* fileName, int matrix[SAMPLES][INOUTPUTS]) {
    FILE* filePointer = fopen(fileName,"w");

	for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS; j++) {
            printf("%d %d %d\n", i, j, matrix[i][j]);
            generateEntryDec(filePointer, matrix, i, j);
        }
        if( i != SAMPLES - 1) fputs("\n", filePointer);
	}

	fclose(filePointer);
}

int main(int argc, char const *argv[])
{
    int w[SAMPLES][INOUTPUTS];
    int a[4];
    int s[SAMPLES][INOUTPUTS];

    int x[SAMPLES][INOUTPUTS];
    int y_dct_4x4  [SAMPLES][INOUTPUTS];
    int y_dst_4x4  [SAMPLES][INOUTPUTS];
    int y_dct_8x8  [SAMPLES][INOUTPUTS];
    int y_dst_8x8  [SAMPLES][INOUTPUTS];
    int y_dct_16x16[SAMPLES][INOUTPUTS];
    int y_dst_16x16[SAMPLES][INOUTPUTS];
    int y_dct_32x32[SAMPLES][INOUTPUTS];
    int y_dst_32x32[SAMPLES][INOUTPUTS];

    srand(time(NULL));

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS; j++) {
            x[i][j] = rand() % 256 - (rand() % 256);
            printf("%d; %d: %d\n", i, j, x[i][j]);
        }
    }

    /*
    int x_84[SAMPLES][INOUTPUTS],  x_74[SAMPLES][INOUTPUTS], x_55[SAMPLES][INOUTPUTS], x_29[SAMPLES][INOUTPUTS];


    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS; j++) {
            x_84[i][j] = x[i][j] * 84;
            x_74[i][j] = x[i][j] * 74;
            x_55[i][j] = x[i][j] * 55;
            x_29[i][j] = x[i][j] * 29;
        }
    }

    */

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 4; j++) {
            for (int k = 0; k < 4; k++) {
                y_dct_4x4[i][j*4 + k] = 0;
                for (int l = 0; l < 4; l++) {
                    y_dct_4x4[i][j*4 + k] += x[i][j*4 + l] * trCoreDCT8P4[l][k];
                    printf("%d\t", trCoreDCT8P4[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dct_4x4[i][j*4 + k]);
            }

            /*y_dct[i][j*4 + 0] = x_84[i][j*4 + 0] + x_74[i][j*4 + 1] + x_55[i][j*4 + 2] + x_29[i][j*4 + 3];
			y_dct[i][j*4 + 1] = x_74[i][j*4 + 0] - x_74[i][j*4 + 2] - x_74[i][j*4 + 3];
			y_dct[i][j*4 + 2] = x_55[i][j*4 + 0] - x_74[i][j*4 + 1] - x_29[i][j*4 + 2] + x_84[i][j*4 + 3];
			y_dct[i][j*4 + 3] = x_29[i][j*4 + 0] - x_74[i][j*4 + 1] + x_84[i][j*4 + 2] - x_55[i][j*4 + 3];*/
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 4; j++) {
            for (int k = 0; k < 4; k++) {
                y_dst_4x4[i][j*4 + k] = 0;
                for (int l = 0; l < 4; l++) {
                    y_dst_4x4[i][j*4 + k] += x[i][j*4 + l] * trCoreDST7P4[l][k];
                    printf("%d\t", trCoreDST7P4[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dst_4x4[i][j*4 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 8; j++) {
            for (int k = 0; k < 8; k++) {
                y_dct_8x8[i][j*8 + k] = 0;
                for (int l = 0; l < 8; l++) {
                    y_dct_8x8[i][j*8 + k] += x[i][j*8 + l] * trCoreDCT8P8[l][k];
                    printf("%d\t", trCoreDCT8P8[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dct_8x8[i][j*8 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 8; j++) {
            for (int k = 0; k < 8; k++) {
                y_dst_8x8[i][j*8 + k] = 0;
                for (int l = 0; l < 8; l++) {
                    y_dst_8x8[i][j*8 + k] += x[i][j*8 + l] * trCoreDST7P8[l][k];
                    printf("%d\t", trCoreDST7P8[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dst_8x8[i][j*8 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 16; j++) {
            for (int k = 0; k < 16; k++) {
                y_dct_16x16[i][j*16 + k] = 0;
                for (int l = 0; l < 16; l++) {
                    y_dct_16x16[i][j*16 + k] += x[i][j*16 + l] * trCoreDCT8P16[l][k];
                    printf("%d\t", trCoreDCT8P16[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dct_16x16[i][j*16 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 16; j++) {
            for (int k = 0; k < 16; k++) {
                y_dst_16x16[i][j*16 + k] = 0;
                for (int l = 0; l < 16; l++) {
                    y_dst_16x16[i][j*16 + k] += x[i][j*16 + l] * trCoreDST7P16[l][k];
                    printf("%d\t", trCoreDST7P16[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dst_16x16[i][j*16 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 32; j++) {
            for (int k = 0; k < 32; k++) {
                y_dct_32x32[i][j*32 + k] = 0;
                for (int l = 0; l < 32; l++) {
                    y_dct_32x32[i][j*32 + k] += x[i][j*32 + l] * trCoreDCT8P32[l][k];
                    printf("%d\t", trCoreDCT8P32[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dct_32x32[i][j*32 + k]);
            }
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 32; j++) {
            for (int k = 0; k < 32; k++) {
                y_dst_32x32[i][j*32 + k] = 0;
                for (int l = 0; l < 32; l++) {
                    y_dst_32x32[i][j*32 + k] += x[i][j*32 + l] * trCoreDST7P32[l][k];
                    printf("%d\t", trCoreDST7P32[l][k]);
                }
                printf("\n%d; %d; %d : %d\n", i, j, k, y_dst_32x32[i][j*32 + k]);
            }
        }
    }

    generateFile("DST7-DCT8_input.txt", x, 9);

    generateFile("DCT8_4x4_output.txt", y_dct_4x4, 16);
    generateFile("DST7_4x4_output.txt", y_dst_4x4, 16);

    generateFile("DCT8_8x8_output.txt", y_dct_8x8, 18);
    generateFile("DST7_8x8_output.txt", y_dst_8x8, 18);

    generateFile("DCT8_16x16_output.txt", y_dct_16x16, 20);
    generateFile("DST7_16x16_output.txt", y_dst_16x16, 20);

    generateFile("DCT8_32x32_output.txt", y_dct_32x32, 20);
    generateFile("DST7_32x32_output.txt", y_dst_32x32, 20);

    generateFileDec("DST7-DCT8_input_dec.txt", x);

    generateFileDec("DCT8_4x4_output_dec.txt", y_dct_4x4);
    generateFileDec("DST7_4x4_output_dec.txt", y_dst_4x4);

    generateFileDec("DCT8_8x8_output_dec.txt", y_dct_8x8);
    generateFileDec("DST7_8x8_output_dec.txt", y_dst_8x8);

    generateFileDec("DCT8_16x16_output_dec.txt", y_dct_16x16);
    generateFileDec("DST7_16x16_output_dec.txt", y_dst_16x16);

    generateFileDec("DCT8_32x32_output_dec.txt", y_dct_32x32);
    generateFileDec("DST7_32x32_output_dec.txt", y_dst_32x32);

    /*int x_86[SAMPLES][64], x_85[SAMPLES][64], x_78[SAMPLES][64], x_71[SAMPLES][64];
    int x_60[SAMPLES][64], x_46[SAMPLES][64], x_32[SAMPLES][64], x_17[SAMPLES][64];

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < 64; j++) {
            x_86[i][j] = x[i][j] * 86;
            x_85[i][j] = x[i][j] * 85;
            x_78[i][j] = x[i][j] * 78;
            x_71[i][j] = x[i][j] * 71;
            x_60[i][j] = x[i][j] * 60;
            x_46[i][j] = x[i][j] * 46;
            x_32[i][j] = x[i][j] * 32;
            x_17[i][j] = x[i][j] * 17;
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 8; j++) {
            y_dct[i][j*8 + 0] = x_86[i][j*8 + 0] + x_85[i][j*8 + 1] + x_78[i][j*8 + 2] + x_71[i][j*8 + 3] + x_60[i][j*8 + 4] + x_46[i][j*8 + 5] + x_32[i][j*8 + 6] + x_17[i][j*8 + 7];
			y_dct[i][j*8 + 1] = x_85[i][j*8 + 0] + x_60[i][j*8 + 1] + x_17[i][j*8 + 2] - x_32[i][j*8 + 3] - x_71[i][j*8 + 4] - x_86[i][j*8 + 5] - x_78[i][j*8 + 6] - x_46[i][j*8 + 7];
			y_dct[i][j*8 + 2] = x_78[i][j*8 + 0] + x_17[i][j*8 + 1] - x_60[i][j*8 + 2] - x_86[i][j*8 + 3] - x_46[i][j*8 + 4] + x_32[i][j*8 + 5] + x_85[i][j*8 + 6] + x_71[i][j*8 + 7];
			y_dct[i][j*8 + 3] = x_71[i][j*8 + 0] - x_32[i][j*8 + 1] - x_86[i][j*8 + 2] - x_17[i][j*8 + 3] + x_78[i][j*8 + 4] + x_60[i][j*8 + 5] - x_46[i][j*8 + 6] - x_85[i][j*8 + 7];
			y_dct[i][j*8 + 4] = x_60[i][j*8 + 0] - x_71[i][j*8 + 1] - x_46[i][j*8 + 2] + x_78[i][j*8 + 3] + x_32[i][j*8 + 4] - x_85[i][j*8 + 5] - x_17[i][j*8 + 6] + x_86[i][j*8 + 7];
			y_dct[i][j*8 + 5] = x_46[i][j*8 + 0] - x_86[i][j*8 + 1] + x_32[i][j*8 + 2] + x_60[i][j*8 + 3] - x_85[i][j*8 + 4] + x_17[i][j*8 + 5] + x_71[i][j*8 + 6] - x_78[i][j*8 + 7];
			y_dct[i][j*8 + 6] = x_32[i][j*8 + 0] - x_78[i][j*8 + 1] + x_85[i][j*8 + 2] - x_46[i][j*8 + 3] - x_17[i][j*8 + 4] + x_71[i][j*8 + 5] - x_86[i][j*8 + 6] + x_60[i][j*8 + 7];
			y_dct[i][j*8 + 7] = x_17[i][j*8 + 0] - x_46[i][j*8 + 1] + x_71[i][j*8 + 2] - x_85[i][j*8 + 3] + x_86[i][j*8 + 4] - x_78[i][j*8 + 5] + x_60[i][j*8 + 6] - x_32[i][j*8 + 7];
        }
    }

    int x_88[SAMPLES][64], x_87[SAMPLES][64], x_85[SAMPLES][64];
    int x_81[SAMPLES][64], x_77[SAMPLES][64], x_73[SAMPLES][64], x_68[SAMPLES][64];
    int x_62[SAMPLES][64], x_55[SAMPLES][64], x_48[SAMPLES][64], x_40[SAMPLES][64];
    int x_33[SAMPLES][64], x_25[SAMPLES][64], x_17[SAMPLES][64], x_8[SAMPLES][64];

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < 64; j++) {
            x_88[i][j] = x[i][j] * 88;
            x_87[i][j] = x[i][j] * 87;
            x_85[i][j] = x[i][j] * 85;
            x_81[i][j] = x[i][j] * 81;
            x_77[i][j] = x[i][j] * 77;
            x_73[i][j] = x[i][j] * 73;
            x_68[i][j] = x[i][j] * 68;
            x_62[i][j] = x[i][j] * 62;
            x_55[i][j] = x[i][j] * 55;
            x_48[i][j] = x[i][j] * 48;
            x_40[i][j] = x[i][j] * 40;
            x_33[i][j] = x[i][j] * 33;
            x_25[i][j] = x[i][j] * 25;
            x_17[i][j] = x[i][j] * 17;
            x_8[i][j] = x[i][j] * 8;
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 16; j++) {
            y_dct[i][j*16 +  0] = x_88[i][j*16 + 0] + x_88[i][i*16 + 1] + x_87[i][j*16 + 2] + x_85[i][j*16 + 3] + x_81[i][j*16 + 4] + x_77[i][j*16 + 5] + x_73[i][j*16 + 6] + x_68[i][j*16 +  7] + x_62[i][j*16 +  8] + x_55[i][j*16 +  9] + x_48[i][j*16 + 10] + x_40[i][j*16 + 11] + x_33[i][j*16 + 12] + x_25[i][j*16 + 13] + x_17[i][j*16 + 14] + x_8[i][j*16 + 15];
		    y_dct[i][j*16 +  1] = x_88[i][j*16 + 0] + x_81[i][i*16 + 1] + x_68[i][j*16 + 2] + x_48[i][j*16 + 3] + x_25[i][j*16 + 4] - x_25[i][j*16 + 6] - x_48[i][j*16 + 7] - x_68[i][j*16 +  8] - x_81[i][j*16 +  9] - x_88[i][j*16 + 10] - x_88[i][j*16 + 11] - x_81[i][j*16 + 12] - x_68[i][j*16 + 13] - x_48[i][j*16 + 14] - x_25[i][j*16 + 15];
		    y_dct[i][j*16 +  2] = x_87[i][j*16 + 0] + x_68[i][i*16 + 1] + x_33[i][j*16 + 2] - x_8 [i][j*16 + 3] - x_48[i][j*16 + 4] - x_77[i][j*16 + 5] - x_88[i][j*16 + 6] - x_81[i][j*16 +  7] - x_55[i][j*16 +  8] - x_17[i][j*16 +  9] + x_25[i][j*16 + 10] + x_62[i][j*16 + 11] + x_85[i][j*16 + 12] + x_88[i][j*16 + 13] + x_73[i][j*16 + 14] + x_40[i][j*16 + 15];
		    y_dct[i][j*16 +  3] = x_85[i][j*16 + 0] + x_48[i][i*16 + 1] - x_8 [i][j*16 + 2] - x_62[i][j*16 + 3] - x_88[i][j*16 + 4] - x_77[i][j*16 + 5] - x_33[i][j*16 + 6] + x_25[i][j*16 +  7] + x_73[i][j*16 +  8] + x_88[i][j*16 +  9] + x_68[i][j*16 + 10] + x_17[i][j*16 + 11] - x_40[i][j*16 + 12] - x_81[i][j*16 + 13] - x_87[i][j*16 + 14] - x_55[i][j*16 + 15];
		    y_dct[i][j*16 +  4] = x_81[i][j*16 + 0] + x_25[i][i*16 + 1] - x_48[i][j*16 + 2] - x_88[i][j*16 + 3] - x_68[i][j*16 + 4] + x_68[i][j*16 + 6] + x_88[i][j*16 + 7] + x_48[i][j*16 +  8] - x_25[i][j*16 +  9] - x_81[i][j*16 + 10] - x_81[i][j*16 + 11] - x_25[i][j*16 + 12] + x_48[i][j*16 + 13] + x_88[i][j*16 + 14] + x_68[i][j*16 + 15];
		    y_dct[i][j*16 +  5] = x_77[i][j*16 + 0] - x_77[i][i*16 + 2] - x_77[i][j*16 + 3] + x_77[i][j*16 + 5] + x_77[i][j*16 + 6] - x_77[i][j*16 + 8] - x_77[i][j*16 + 9] + x_77[i][j*16 + 11] + x_77[i][j*16 + 12] - x_77[i][j*16 + 14] - x_77[i][j*16 + 15];
		    y_dct[i][j*16 +  6] = x_73[i][j*16 + 0] - x_25[i][i*16 + 1] - x_88[i][j*16 + 2] - x_33[i][j*16 + 3] + x_68[i][j*16 + 4] + x_77[i][j*16 + 5] - x_17[i][j*16 + 6] - x_88[i][j*16 +  7] - x_40[i][j*16 +  8] + x_62[i][j*16 +  9] + x_81[i][j*16 + 10] - x_8 [i][j*16 + 11] - x_87[i][j*16 + 12] - x_48[i][j*16 + 13] + x_55[i][j*16 + 14] + x_85[i][j*16 + 15];
		    y_dct[i][j*16 +  7] = x_68[i][j*16 + 0] - x_48[i][i*16 + 1] - x_81[i][j*16 + 2] + x_25[i][j*16 + 3] + x_88[i][j*16 + 4] - x_88[i][j*16 + 6] - x_25[i][j*16 + 7] + x_81[i][j*16 +  8] + x_48[i][j*16 +  9] - x_68[i][j*16 + 10] - x_68[i][j*16 + 11] + x_48[i][j*16 + 12] + x_81[i][j*16 + 13] - x_25[i][j*16 + 14] - x_88[i][j*16 + 15];
		    y_dct[i][j*16 +  8] = x_62[i][j*16 + 0] - x_68[i][i*16 + 1] - x_55[i][j*16 + 2] + x_73[i][j*16 + 3] + x_48[i][j*16 + 4] - x_77[i][j*16 + 5] - x_40[i][j*16 + 6] + x_81[i][j*16 +  7] + x_33[i][j*16 +  8] - x_85[i][j*16 +  9] - x_25[i][j*16 + 10] + x_87[i][j*16 + 11] + x_17[i][j*16 + 12] - x_88[i][j*16 + 13] - x_8 [i][j*16 + 14] + x_88[i][j*16 + 15];
		    y_dct[i][j*16 +  9] = x_55[i][j*16 + 0] - x_81[i][i*16 + 1] - x_17[i][j*16 + 2] + x_88[i][j*16 + 3] - x_25[i][j*16 + 4] - x_77[i][j*16 + 5] + x_62[i][j*16 + 6] + x_48[i][j*16 +  7] - x_85[i][j*16 +  8] - x_8 [i][j*16 +  9] + x_88[i][j*16 + 10] - x_33[i][j*16 + 11] - x_73[i][j*16 + 12] + x_68[i][j*16 + 13] + x_40[i][j*16 + 14] - x_87[i][j*16 + 15];
		    y_dct[i][j*16 + 10] = x_48[i][j*16 + 0] - x_88[i][i*16 + 1] + x_25[i][j*16 + 2] + x_68[i][j*16 + 3] - x_81[i][j*16 + 4] + x_81[i][j*16 + 6] - x_68[i][j*16 + 7] - x_25[i][j*16 +  8] + x_88[i][j*16 +  9] - x_48[i][j*16 + 10] - x_48[i][j*16 + 11] + x_88[i][j*16 + 12] - x_25[i][j*16 + 13] - x_68[i][j*16 + 14] + x_81[i][j*16 + 15];
		    y_dct[i][j*16 + 11] = x_40[i][j*16 + 0] - x_88[i][i*16 + 1] + x_62[i][j*16 + 2] + x_17[i][j*16 + 3] - x_81[i][j*16 + 4] + x_77[i][j*16 + 5] - x_8 [i][j*16 + 6] - x_68[i][j*16 +  7] + x_87[i][j*16 +  8] - x_33[i][j*16 +  9] - x_48[i][j*16 + 10] + x_88[i][j*16 + 11] - x_55[i][j*16 + 12] - x_25[i][j*16 + 13] + x_85[i][j*16 + 14] - x_73[i][j*16 + 15];
		    y_dct[i][j*16 + 12] = x_33[i][j*16 + 0] - x_81[i][i*16 + 1] + x_85[i][j*16 + 2] - x_40[i][j*16 + 3] - x_25[i][j*16 + 4] + x_77[i][j*16 + 5] - x_87[i][j*16 + 6] + x_48[i][j*16 +  7] + x_17[i][j*16 +  8] - x_73[i][j*16 +  9] + x_88[i][j*16 + 10] - x_55[i][j*16 + 11] - x_8 [i][j*16 + 12] + x_68[i][j*16 + 13] - x_88[i][j*16 + 14] + x_62[i][j*16 + 15];
		    y_dct[i][j*16 + 13] = x_25[i][j*16 + 0] - x_68[i][i*16 + 1] + x_88[i][j*16 + 2] - x_81[i][j*16 + 3] + x_48[i][j*16 + 4] - x_48[i][j*16 + 6] + x_81[i][j*16 + 7] - x_88[i][j*16 +  8] + x_68[i][j*16 +  9] - x_25[i][j*16 + 10] - x_25[i][j*16 + 11] + x_68[i][j*16 + 12] - x_88[i][j*16 + 13] + x_81[i][j*16 + 14] - x_48[i][j*16 + 15];
		    y_dct[i][j*16 + 14] = x_17[i][j*16 + 0] - x_48[i][i*16 + 1] + x_73[i][j*16 + 2] - x_87[i][j*16 + 3] + x_88[i][j*16 + 4] - x_77[i][j*16 + 5] + x_55[i][j*16 + 6] - x_25[i][j*16 +  7] - x_8 [i][j*16 +  8] + x_40[i][j*16 +  9] - x_68[i][j*16 + 10] + x_85[i][j*16 + 11] - x_88[i][j*16 + 12] + x_81[i][j*16 + 13] - x_62[i][j*16 + 14] + x_33[i][j*16 + 15];
		    y_dct[i][j*16 + 15] = x_8 [i][j*16 + 0] - x_25[i][i*16 + 1] + x_40[i][j*16 + 2] - x_55[i][j*16 + 3] + x_68[i][j*16 + 4] - x_77[i][j*16 + 5] + x_85[i][j*16 + 6] - x_88[i][j*16 +  7] + x_88[i][j*16 +  8] - x_87[i][j*16 +  9] + x_81[i][j*16 + 10] - x_73[i][j*16 + 11] + x_62[i][j*16 + 12] - x_48[i][j*16 + 13] + x_33[i][j*16 + 14] - x_17[i][j*16 + 15];        }
    }

    int x_90[SAMPLES][64], x_89[SAMPLES][64], x_88[SAMPLES][64];
    int x_87[SAMPLES][64], x_86[SAMPLES][64], x_85[SAMPLES][64], x_84[SAMPLES][64];
    int x_82[SAMPLES][64], x_80[SAMPLES][64], x_78[SAMPLES][64], x_77[SAMPLES][64];
    int x_74[SAMPLES][64], x_72[SAMPLES][64], x_68[SAMPLES][64], x_66[SAMPLES][64];
    int x_63[SAMPLES][64], x_60[SAMPLES][64], x_56[SAMPLES][64], x_53[SAMPLES][64];
    int x_50[SAMPLES][64], x_46[SAMPLES][64], x_42[SAMPLES][64], x_38[SAMPLES][64];
    int x_34[SAMPLES][64], x_30[SAMPLES][64], x_26[SAMPLES][64], x_21[SAMPLES][64];
    int x_17[SAMPLES][64], x_13[SAMPLES][64], x_9 [SAMPLES][64], x_4 [SAMPLES][64];

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < 64; j++) {
            x_90[i][j] = x[i][j] * 90;
            x_89[i][j] = x[i][j] * 89;
            x_88[i][j] = x[i][j] * 88;
            x_87[i][j] = x[i][j] * 87;
            x_86[i][j] = x[i][j] * 86;
            x_85[i][j] = x[i][j] * 85;
            x_84[i][j] = x[i][j] * 84;
            x_82[i][j] = x[i][j] * 82;
            x_80[i][j] = x[i][j] * 80;
            x_78[i][j] = x[i][j] * 78;
            x_77[i][j] = x[i][j] * 77;
            x_74[i][j] = x[i][j] * 74;
            x_72[i][j] = x[i][j] * 72;
            x_68[i][j] = x[i][j] * 68;
            x_66[i][j] = x[i][j] * 66;
            x_63[i][j] = x[i][j] * 63;
            x_60[i][j] = x[i][j] * 60;
            x_56[i][j] = x[i][j] * 56;
            x_53[i][j] = x[i][j] * 53;
            x_50[i][j] = x[i][j] * 50;
            x_46[i][j] = x[i][j] * 46;
            x_42[i][j] = x[i][j] * 42;
            x_38[i][j] = x[i][j] * 38;
            x_34[i][j] = x[i][j] * 34;
            x_30[i][j] = x[i][j] * 30;
            x_26[i][j] = x[i][j] * 26;
            x_21[i][j] = x[i][j] * 21;
            x_17[i][j] = x[i][j] * 17;
            x_13[i][j] = x[i][j] * 13;
            x_9[i][j] = x[i][j] * 9;
            x_4[i][j] = x[i][j] * 4;
        }
    }

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < INOUTPUTS / 32; j++) {
            y_dct[i][j*32 +  0] = x_90[i][j*32 + 0] + x_90[i][i*32 + 1] + x_89[i][j*32 + 2] + x_88[i][j*32 + 3] + x_87[i][j*32 + 4] + x_86[i][j*32 + 5] + x_85[i][j*32 + 6] + x_84[i][j*32 + 7] + x_82[i][j*32 +  8] + x_80[i][j*32 +  9] + x_78[i][j*32 + 10] + x_77[i][j*32 + 11] + x_74[i][j*32 + 12] + x_72[i][j*32 + 13] + x_68[i][j*32 + 14] + x_66[i][j*32 + 15] + x_63[i][j*32 + 16] + x_60[i][j*32 + 17] + x_56[i][j*32 + 18] + x_53[i][j*32 + 19] + x_50[i][j*32 + 20] + x_46[i][j*32 + 21] + x_42[i][j*32 + 22] + x_38[i][j*32 + 23] + x_34[i][j*32 + 24] + x_30[i][j*32 + 25] + x_26[i][j*32 + 26] + x_21[i][j*32 + 27] + x_17[i][j*32 + 28] + x_13[i][j*32 + 29] + x_9 [i][j*32 + 30] + x_4 [i][j*32 + 31];
			y_dct[i][j*32 +  1] = x_90[i][j*32 + 0] + x_87[i][i*32 + 1] + x_84[i][j*32 + 2] + x_78[i][j*32 + 3] + x_72[i][j*32 + 4] + x_63[i][j*32 + 5] + x_53[i][j*32 + 6] + x_42[i][j*32 + 7] + x_30[i][j*32 +  8] + x_17[i][j*32 +  9] + x_4 [i][j*32 + 10] - x_9 [i][j*32 + 11] - x_21[i][j*32 + 12] - x_34[i][j*32 + 13] - x_46[i][j*32 + 14] - x_56[i][j*32 + 15] - x_66[i][j*32 + 16] - x_74[i][j*32 + 17] - x_80[i][j*32 + 18] - x_85[i][j*32 + 19] - x_88[i][j*32 + 20] - x_90[i][j*32 + 21] - x_89[i][j*32 + 22] - x_86[i][j*32 + 23] - x_82[i][j*32 + 24] - x_77[i][j*32 + 25] - x_68[i][j*32 + 26] - x_60[i][j*32 + 27] - x_50[i][j*32 + 28] - x_38[i][j*32 + 29] - x_26[i][j*32 + 30] - x_13[i][j*32 + 31];
			y_dct[i][j*32 +  2] = x_89[i][j*32 + 0] + x_84[i][i*32 + 1] + x_74[i][j*32 + 2] + x_60[i][j*32 + 3] + x_42[i][j*32 + 4] + x_21[i][j*32 + 5] - x_21[i][j*32 + 7] - x_42[i][j*32 + 8] - x_60[i][j*32 +  9] - x_74[i][j*32 + 10] - x_84[i][j*32 + 11] - x_89[i][j*32 + 12] - x_89[i][j*32 + 13] - x_84[i][j*32 + 14] - x_74[i][j*32 + 15] - x_60[i][j*32 + 16] - x_42[i][j*32 + 17] - x_21[i][j*32 + 18] + x_21[i][j*32 + 20] + x_42[i][j*32 + 21] + x_60[i][j*32 + 22] + x_74[i][j*32 + 23] + x_84[i][j*32 + 24] + x_89[i][j*32 + 25] + x_89[i][j*32 + 26] + x_84[i][j*32 + 27] + x_74[i][j*32 + 28] + x_60[i][j*32 + 29] + x_42[i][j*32 + 30] + x_21[i][j*32 + 31];
			y_dct[i][j*32 +  3] = x_88[i][j*32 + 0] + x_78[i][i*32 + 1] + x_60[i][j*32 + 2] + x_34[i][j*32 + 3] + x_4 [i][j*32 + 4] - x_26[i][j*32 + 5] - x_53[i][j*32 + 6] - x_74[i][j*32 + 7] - x_86[i][j*32 +  8] - x_90[i][j*32 +  9] - x_82[i][j*32 + 10] - x_66[i][j*32 + 11] - x_42[i][j*32 + 12] - x_13[i][j*32 + 13] + x_17[i][j*32 + 14] + x_46[i][j*32 + 15] + x_68[i][j*32 + 16] + x_84[i][j*32 + 17] + x_90[i][j*32 + 18] + x_85[i][j*32 + 19] + x_72[i][j*32 + 20] + x_50[i][j*32 + 21] + x_21[i][j*32 + 22] - x_9 [i][j*32 + 23] - x_38[i][j*32 + 24] - x_63[i][j*32 + 25] - x_80[i][j*32 + 26] - x_89[i][j*32 + 27] - x_87[i][j*32 + 28] - x_77[i][j*32 + 29] - x_56[i][j*32 + 30] - x_30[i][j*32 + 31];
			y_dct[i][j*32 +  4] = x_87[i][j*32 + 0] + x_72[i][i*32 + 1] + x_42[i][j*32 + 2] + x_4 [i][j*32 + 3] - x_34[i][j*32 + 4] - x_66[i][j*32 + 5] - x_85[i][j*32 + 6] - x_89[i][j*32 + 7] - x_77[i][j*32 +  8] - x_50[i][j*32 +  9] - x_13[i][j*32 + 10] + x_26[i][j*32 + 11] + x_60[i][j*32 + 12] + x_82[i][j*32 + 13] + x_90[i][j*32 + 14] + x_80[i][j*32 + 15] + x_56[i][j*32 + 16] + x_21[i][j*32 + 17] - x_17[i][j*32 + 18] - x_53[i][j*32 + 19] - x_78[i][j*32 + 20] - x_90[i][j*32 + 21] - x_84[i][j*32 + 22] - x_63[i][j*32 + 23] - x_30[i][j*32 + 24] + x_9 [i][j*32 + 25] + x_46[i][j*32 + 26] + x_74[i][j*32 + 27] + x_88[i][j*32 + 28] + x_86[i][j*32 + 29] + x_68[i][j*32 + 30] + x_38[i][j*32 + 31];
			y_dct[i][j*32 +  5] = x_86[i][j*32 + 0] + x_63[i][i*32 + 1] + x_21[i][j*32 + 2] - x_26[i][j*32 + 3] - x_66[i][j*32 + 4] - x_87[i][j*32 + 5] - x_85[i][j*32 + 6] - x_60[i][j*32 + 7] - x_17[i][j*32 +  8] + x_30[i][j*32 +  9] + x_68[i][j*32 + 10] + x_88[i][j*32 + 11] + x_84[i][j*32 + 12] + x_56[i][j*32 + 13] + x_13[i][j*32 + 14] - x_34[i][j*32 + 15] - x_72[i][j*32 + 16] - x_89[i][j*32 + 17] - x_82[i][j*32 + 18] - x_53[i][j*32 + 19] - x_9 [i][j*32 + 20] + x_38[i][j*32 + 21] + x_74[i][j*32 + 22] + x_90[i][j*32 + 23] + x_80[i][j*32 + 24] + x_50[i][j*32 + 25] + x_4 [i][j*32 + 26] - x_42[i][j*32 + 27] - x_77[i][j*32 + 28] - x_90[i][j*32 + 29] - x_78[i][j*32 + 30] - x_46[i][j*32 + 31];
			y_dct[i][j*32 +  6] = x_85[i][j*32 + 0] + x_53[i][i*32 + 1] - x_53[i][j*32 + 3] - x_85[i][j*32 + 4] - x_85[i][j*32 + 5] - x_53[i][j*32 + 6] + x_53[i][j*32 + 8] + x_85[i][j*32 + 9] + x_85[i][j*32 + 10] + x_53[i][j*32 + 11] - x_53[i][j*32 + 13] - x_85[i][j*32 + 14] - x_85[i][j*32 + 15] - x_53[i][j*32 + 16] + x_53[i][j*32 + 18] + x_85[i][j*32 + 19] + x_85[i][j*32 + 20] + x_53[i][j*32 + 21] - x_53[i][j*32 + 23] - x_85[i][j*32 + 24] - x_85[i][j*32 + 25] - x_53[i][j*32 + 26] + x_53[i][j*32 + 28] + x_85[i][j*32 + 29] + x_85[i][j*32 + 30] + x_53[i][j*32 + 31];
			y_dct[i][j*32 +  7] = x_84[i][j*32 + 0] + x_42[i][i*32 + 1] - x_21[i][j*32 + 2] - x_74[i][j*32 + 3] - x_89[i][j*32 + 4] - x_60[i][j*32 + 5] + x_60[i][j*32 + 7] + x_89[i][j*32 + 8] + x_74[i][j*32 +  9] + x_21[i][j*32 + 10] - x_42[i][j*32 + 11] - x_84[i][j*32 + 12] - x_84[i][j*32 + 13] - x_42[i][j*32 + 14] + x_21[i][j*32 + 15] + x_74[i][j*32 + 16] + x_89[i][j*32 + 17] + x_60[i][j*32 + 18] - x_60[i][j*32 + 20] - x_89[i][j*32 + 21] - x_74[i][j*32 + 22] - x_21[i][j*32 + 23] + x_42[i][j*32 + 24] + x_84[i][j*32 + 25] + x_84[i][j*32 + 26] + x_42[i][j*32 + 27] - x_21[i][j*32 + 28] - x_74[i][j*32 + 29] - x_89[i][j*32 + 30] - x_60[i][j*32 + 31];
			y_dct[i][j*32 +  8] = x_82[i][j*32 + 0] + x_30[i][i*32 + 1] - x_42[i][j*32 + 2] - x_86[i][j*32 + 3] - x_77[i][j*32 + 4] - x_17[i][j*32 + 5] + x_53[i][j*32 + 6] + x_89[i][j*32 + 7] + x_68[i][j*32 +  8] + x_4 [i][j*32 +  9] - x_63[i][j*32 + 10] - x_90[i][j*32 + 11] - x_60[i][j*32 + 12] + x_9 [i][j*32 + 13] + x_72[i][j*32 + 14] + x_88[i][j*32 + 15] + x_50[i][j*32 + 16] - x_21[i][j*32 + 17] - x_78[i][j*32 + 18] - x_85[i][j*32 + 19] - x_38[i][j*32 + 20] + x_34[i][j*32 + 21] + x_84[i][j*32 + 22] + x_80[i][j*32 + 23] + x_26[i][j*32 + 24] - x_46[i][j*32 + 25] - x_87[i][j*32 + 26] - x_74[i][j*32 + 27] - x_13[i][j*32 + 28] + x_56[i][j*32 + 29] + x_90[i][j*32 + 30] + x_66[i][j*32 + 31];
			y_dct[i][j*32 +  9] = x_80[i][j*32 + 0] + x_17[i][i*32 + 1] - x_60[i][j*32 + 2] - x_90[i][j*32 + 3] - x_50[i][j*32 + 4] + x_30[i][j*32 + 5] + x_85[i][j*32 + 6] + x_74[i][j*32 + 7] + x_4 [i][j*32 +  8] - x_68[i][j*32 +  9] - x_87[i][j*32 + 10] - x_38[i][j*32 + 11] + x_42[i][j*32 + 12] + x_88[i][j*32 + 13] + x_66[i][j*32 + 14] - x_9 [i][j*32 + 15] - x_77[i][j*32 + 16] - x_84[i][j*32 + 17] - x_26[i][j*32 + 18] + x_53[i][j*32 + 19] + x_90[i][j*32 + 20] + x_56[i][j*32 + 21] - x_21[i][j*32 + 22] - x_82[i][j*32 + 23] - x_78[i][j*32 + 24] - x_13[i][j*32 + 25] + x_63[i][j*32 + 26] + x_89[i][j*32 + 27] + x_46[i][j*32 + 28] - x_34[i][j*32 + 29] - x_86[i][j*32 + 30] - x_72[i][j*32 + 31];
			y_dct[i][j*32 + 10] = x_78[i][j*32 + 0] + x_4 [i][i*32 + 1] - x_74[i][j*32 + 2] - x_82[i][j*32 + 3] - x_13[i][j*32 + 4] + x_68[i][j*32 + 5] + x_85[i][j*32 + 6] + x_21[i][j*32 + 7] - x_63[i][j*32 +  8] - x_87[i][j*32 +  9] - x_30[i][j*32 + 10] + x_56[i][j*32 + 11] + x_89[i][j*32 + 12] + x_38[i][j*32 + 13] - x_50[i][j*32 + 14] - x_90[i][j*32 + 15] - x_46[i][j*32 + 16] + x_42[i][j*32 + 17] + x_90[i][j*32 + 18] + x_53[i][j*32 + 19] - x_34[i][j*32 + 20] - x_88[i][j*32 + 21] - x_60[i][j*32 + 22] + x_26[i][j*32 + 23] + x_86[i][j*32 + 24] + x_66[i][j*32 + 25] - x_17[i][j*32 + 26] - x_84[i][j*32 + 27] - x_72[i][j*32 + 28] + x_9 [i][j*32 + 29] + x_80[i][j*32 + 30] + x_77[i][j*32 + 31];
			y_dct[i][j*32 + 11] = x_77[i][j*32 + 0] - x_9 [i][i*32 + 1] - x_84[i][j*32 + 2] - x_66[i][j*32 + 3] + x_26[i][j*32 + 4] + x_88[i][j*32 + 5] + x_53[i][j*32 + 6] - x_42[i][j*32 + 7] - x_90[i][j*32 +  8] - x_38[i][j*32 +  9] + x_56[i][j*32 + 10] + x_87[i][j*32 + 11] + x_21[i][j*32 + 12] - x_68[i][j*32 + 13] - x_82[i][j*32 + 14] - x_4 [i][j*32 + 15] + x_78[i][j*32 + 16] + x_74[i][j*32 + 17] - x_13[i][j*32 + 18] - x_85[i][j*32 + 19] - x_63[i][j*32 + 20] + x_30[i][j*32 + 21] + x_89[i][j*32 + 22] + x_50[i][j*32 + 23] - x_46[i][j*32 + 24] - x_90[i][j*32 + 25] - x_34[i][j*32 + 26] + x_60[i][j*32 + 27] + x_86[i][j*32 + 28] + x_17[i][j*32 + 29] - x_72[i][j*32 + 30] - x_80[i][j*32 + 31];
			y_dct[i][j*32 + 12] = x_74[i][j*32 + 0] - x_21[i][i*32 + 1] - x_89[i][j*32 + 2] - x_42[i][j*32 + 3] + x_60[i][j*32 + 4] + x_84[i][j*32 + 5] - x_84[i][j*32 + 7] - x_60[i][j*32 + 8] + x_42[i][j*32 +  9] + x_89[i][j*32 + 10] + x_21[i][j*32 + 11] - x_74[i][j*32 + 12] - x_74[i][j*32 + 13] + x_21[i][j*32 + 14] + x_89[i][j*32 + 15] + x_42[i][j*32 + 16] - x_60[i][j*32 + 17] - x_84[i][j*32 + 18] + x_84[i][j*32 + 20] + x_60[i][j*32 + 21] - x_42[i][j*32 + 22] - x_89[i][j*32 + 23] - x_21[i][j*32 + 24] + x_74[i][j*32 + 25] + x_74[i][j*32 + 26] - x_21[i][j*32 + 27] - x_89[i][j*32 + 28] - x_42[i][j*32 + 29] + x_60[i][j*32 + 30] + x_84[i][j*32 + 31];
			y_dct[i][j*32 + 13] = x_72[i][j*32 + 0] - x_34[i][i*32 + 1] - x_89[i][j*32 + 2] - x_13[i][j*32 + 3] + x_82[i][j*32 + 4] + x_56[i][j*32 + 5] - x_53[i][j*32 + 6] - x_84[i][j*32 + 7] + x_9 [i][j*32 +  8] + x_88[i][j*32 +  9] + x_38[i][j*32 + 10] - x_68[i][j*32 + 11] - x_74[i][j*32 + 12] + x_30[i][j*32 + 13] + x_90[i][j*32 + 14] + x_17[i][j*32 + 15] - x_80[i][j*32 + 16] - x_60[i][j*32 + 17] + x_50[i][j*32 + 18] + x_85[i][j*32 + 19] - x_4 [i][j*32 + 20] - x_87[i][j*32 + 21] - x_42[i][j*32 + 22] + x_66[i][j*32 + 23] + x_77[i][j*32 + 24] - x_26[i][j*32 + 25] - x_90[i][j*32 + 26] - x_21[i][j*32 + 27] + x_78[i][j*32 + 28] + x_63[i][j*32 + 29] - x_46[i][j*32 + 30] - x_86[i][j*32 + 31];
			y_dct[i][j*32 + 14] = x_68[i][j*32 + 0] - x_46[i][i*32 + 1] - x_84[i][j*32 + 2] + x_17[i][j*32 + 3] + x_90[i][j*32 + 4] + x_13[i][j*32 + 5] - x_85[i][j*32 + 6] - x_42[i][j*32 + 7] + x_72[i][j*32 +  8] + x_66[i][j*32 +  9] - x_50[i][j*32 + 10] - x_82[i][j*32 + 11] + x_21[i][j*32 + 12] + x_90[i][j*32 + 13] + x_9 [i][j*32 + 14] - x_86[i][j*32 + 15] - x_38[i][j*32 + 16] + x_74[i][j*32 + 17] + x_63[i][j*32 + 18] - x_53[i][j*32 + 19] - x_80[i][j*32 + 20] + x_26[i][j*32 + 21] + x_89[i][j*32 + 22] + x_4 [i][j*32 + 23] - x_87[i][j*32 + 24] - x_34[i][j*32 + 25] + x_77[i][j*32 + 26] + x_60[i][j*32 + 27] - x_56[i][j*32 + 28] - x_78[i][j*32 + 29] + x_30[i][j*32 + 30] + x_88[i][j*32 + 31];
			y_dct[i][j*32 + 15] = x_66[i][j*32 + 0] - x_56[i][i*32 + 1] - x_74[i][j*32 + 2] + x_46[i][j*32 + 3] + x_80[i][j*32 + 4] - x_34[i][j*32 + 5] - x_85[i][j*32 + 6] + x_21[i][j*32 + 7] + x_88[i][j*32 +  8] - x_9 [i][j*32 +  9] - x_90[i][j*32 + 10] - x_4 [i][j*32 + 11] + x_89[i][j*32 + 12] + x_17[i][j*32 + 13] - x_86[i][j*32 + 14] - x_30[i][j*32 + 15] + x_82[i][j*32 + 16] + x_42[i][j*32 + 17] - x_77[i][j*32 + 18] - x_53[i][j*32 + 19] + x_68[i][j*32 + 20] + x_63[i][j*32 + 21] - x_60[i][j*32 + 22] - x_72[i][j*32 + 23] + x_50[i][j*32 + 24] + x_78[i][j*32 + 25] - x_38[i][j*32 + 26] - x_84[i][j*32 + 27] + x_26[i][j*32 + 28] + x_87[i][j*32 + 29] - x_13[i][j*32 + 30] - x_90[i][j*32 + 31];
			y_dct[i][j*32 + 16] = x_63[i][j*32 + 0] - x_66[i][i*32 + 1] - x_60[i][j*32 + 2] + x_68[i][j*32 + 3] + x_56[i][j*32 + 4] - x_72[i][j*32 + 5] - x_53[i][j*32 + 6] + x_74[i][j*32 + 7] + x_50[i][j*32 +  8] - x_77[i][j*32 +  9] - x_46[i][j*32 + 10] + x_78[i][j*32 + 11] + x_42[i][j*32 + 12] - x_80[i][j*32 + 13] - x_38[i][j*32 + 14] + x_82[i][j*32 + 15] + x_34[i][j*32 + 16] - x_84[i][j*32 + 17] - x_30[i][j*32 + 18] + x_85[i][j*32 + 19] + x_26[i][j*32 + 20] - x_86[i][j*32 + 21] - x_21[i][j*32 + 22] + x_87[i][j*32 + 23] + x_17[i][j*32 + 24] - x_88[i][j*32 + 25] - x_13[i][j*32 + 26] + x_89[i][j*32 + 27] + x_9 [i][j*32 + 28] - x_90[i][j*32 + 29] - x_4 [i][j*32 + 30] + x_90[i][j*32 + 31];
			y_dct[i][j*32 + 17] = x_60[i][j*32 + 0] - x_74[i][i*32 + 1] - x_42[i][j*32 + 2] + x_84[i][j*32 + 3] + x_21[i][j*32 + 4] - x_89[i][j*32 + 5] + x_89[i][j*32 + 7] - x_21[i][j*32 + 8] - x_84[i][j*32 +  9] + x_42[i][j*32 + 10] + x_74[i][j*32 + 11] - x_60[i][j*32 + 12] - x_60[i][j*32 + 13] + x_74[i][j*32 + 14] + x_42[i][j*32 + 15] - x_84[i][j*32 + 16] - x_21[i][j*32 + 17] + x_89[i][j*32 + 18] - x_89[i][j*32 + 20] + x_21[i][j*32 + 21] + x_84[i][j*32 + 22] - x_42[i][j*32 + 23] - x_74[i][j*32 + 24] + x_60[i][j*32 + 25] + x_60[i][j*32 + 26] - x_74[i][j*32 + 27] - x_42[i][j*32 + 28] + x_84[i][j*32 + 29] + x_21[i][j*32 + 30] - x_89[i][j*32 + 31];
			y_dct[i][j*32 + 18] = x_56[i][j*32 + 0] - x_80[i][i*32 + 1] - x_21[i][j*32 + 2] + x_90[i][j*32 + 3] - x_17[i][j*32 + 4] - x_82[i][j*32 + 5] + x_53[i][j*32 + 6] + x_60[i][j*32 + 7] - x_78[i][j*32 +  8] - x_26[i][j*32 +  9] + x_90[i][j*32 + 10] - x_13[i][j*32 + 11] - x_84[i][j*32 + 12] + x_50[i][j*32 + 13] + x_63[i][j*32 + 14] - x_77[i][j*32 + 15] - x_30[i][j*32 + 16] + x_89[i][j*32 + 17] - x_9 [i][j*32 + 18] - x_85[i][j*32 + 19] + x_46[i][j*32 + 20] + x_66[i][j*32 + 21] - x_74[i][j*32 + 22] - x_34[i][j*32 + 23] + x_88[i][j*32 + 24] - x_4 [i][j*32 + 25] - x_86[i][j*32 + 26] + x_42[i][j*32 + 27] + x_68[i][j*32 + 28] - x_72[i][j*32 + 29] - x_38[i][j*32 + 30] + x_87[i][j*32 + 31];
			y_dct[i][j*32 + 19] = x_53[i][j*32 + 0] - x_85[i][i*32 + 1] + x_85[i][j*32 + 3] - x_53[i][j*32 + 4] - x_53[i][j*32 + 5] + x_85[i][j*32 + 6] - x_85[i][j*32 + 8] + x_53[i][j*32 + 9] + x_53[i][j*32 + 10] - x_85[i][j*32 + 11] + x_85[i][j*32 + 13] - x_53[i][j*32 + 14] - x_53[i][j*32 + 15] + x_85[i][j*32 + 16] - x_85[i][j*32 + 18] + x_53[i][j*32 + 19] + x_53[i][j*32 + 20] - x_85[i][j*32 + 21] + x_85[i][j*32 + 23] - x_53[i][j*32 + 24] - x_53[i][j*32 + 25] + x_85[i][j*32 + 26] - x_85[i][j*32 + 28] + x_53[i][j*32 + 29] + x_53[i][j*32 + 30] - x_85[i][j*32 + 31];
			y_dct[i][j*32 + 20] = x_50[i][j*32 + 0] - x_88[i][i*32 + 1] + x_21[i][j*32 + 2] + x_72[i][j*32 + 3] - x_78[i][j*32 + 4] - x_9 [i][j*32 + 5] + x_85[i][j*32 + 6] - x_60[i][j*32 + 7] - x_38[i][j*32 +  8] + x_90[i][j*32 +  9] - x_34[i][j*32 + 10] - x_63[i][j*32 + 11] + x_84[i][j*32 + 12] - x_4 [i][j*32 + 13] - x_80[i][j*32 + 14] + x_68[i][j*32 + 15] + x_26[i][j*32 + 16] - x_89[i][j*32 + 17] + x_46[i][j*32 + 18] + x_53[i][j*32 + 19] - x_87[i][j*32 + 20] + x_17[i][j*32 + 21] + x_74[i][j*32 + 22] - x_77[i][j*32 + 23] - x_13[i][j*32 + 24] + x_86[i][j*32 + 25] - x_56[i][j*32 + 26] - x_42[i][j*32 + 27] + x_90[i][j*32 + 28] - x_30[i][j*32 + 29] - x_66(i*32 + 30) + x_82(i*32 + 31);
			y_dct[i][j*32 + 21] = x_46[i][j*32 + 0] - x_90[i][i*32 + 1] + x_42[i][j*32 + 2] + x_50[i][j*32 + 3] - x_90[i][j*32 + 4] + x_38[i][j*32 + 5] + x_53[i][j*32 + 6] - x_89[i][j*32 + 7] + x_34[i][j*32 +  8] + x_56[i][j*32 +  9] - x_88[i][j*32 + 10] + x_30[i][j*32 + 11] + x_60[i][j*32 + 12] - x_87[i][j*32 + 13] + x_26[i][j*32 + 14] + x_63[i][j*32 + 15] - x_86[i][j*32 + 16] + x_21[i][j*32 + 17] + x_66[i][j*32 + 18] - x_85[i][j*32 + 19] + x_17[i][j*32 + 20] + x_68[i][j*32 + 21] - x_84[i][j*32 + 22] + x_13[i][j*32 + 23] + x_72[i][j*32 + 24] - x_82[i][j*32 + 25] + x_9 [i][j*32 + 26] + x_74[i][j*32 + 27] - x_80[i][j*32 + 28] + x_4 [i][j*32 + 29] + x_77(i*32 + 30) - x_78(i*32 + 31);
			y_dct[i][j*32 + 22] = x_42[i][j*32 + 0] - x_89[i][i*32 + 1] + x_60[i][j*32 + 2] + x_21[i][j*32 + 3] - x_84[i][j*32 + 4] + x_74[i][j*32 + 5] - x_74[i][j*32 + 7] + x_84[i][j*32 + 8] - x_21[i][j*32 +  9] - x_60[i][j*32 + 10] + x_89[i][j*32 + 11] - x_42[i][j*32 + 12] - x_42[i][j*32 + 13] + x_89[i][j*32 + 14] - x_60[i][j*32 + 15] - x_21[i][j*32 + 16] + x_84[i][j*32 + 17] - x_74[i][j*32 + 18] + x_74[i][j*32 + 20] - x_84[i][j*32 + 21] + x_21[i][j*32 + 22] + x_60[i][j*32 + 23] - x_89[i][j*32 + 24] + x_42[i][j*32 + 25] + x_42[i][j*32 + 26] - x_89[i][j*32 + 27] + x_60[i][j*32 + 28] + x_21[i][j*32 + 29] - x_84[i][j*32 + 30] + x_74[i][j*32 + 31];
			y_dct[i][j*32 + 23] = x_38[i][j*32 + 0] - x_86[i][i*32 + 1] + x_74[i][j*32 + 2] - x_9 [i][j*32 + 3] - x_63[i][j*32 + 4] + x_90[i][j*32 + 5] - x_53[i][j*32 + 6] - x_21[i][j*32 + 7] + x_80[i][j*32 +  8] - x_82[i][j*32 +  9] + x_26[i][j*32 + 10] + x_50[i][j*32 + 11] - x_89[i][j*32 + 12] + x_66[i][j*32 + 13] + x_4 [i][j*32 + 14] - x_72[i][j*32 + 15] + x_87[i][j*32 + 16] - x_42[i][j*32 + 17] - x_34[i][j*32 + 18] + x_85[i][j*32 + 19] - x_77[i][j*32 + 20] + x_13[i][j*32 + 21] + x_60[i][j*32 + 22] - x_90[i][j*32 + 23] + x_56[i][j*32 + 24] + x_17[i][j*32 + 25] - x_78[i][j*32 + 26] + x_84[i][j*32 + 27] - x_30[i][j*32 + 28] - x_46[i][j*32 + 29] + x_88(i*32 + 30) - x_68(i*32 + 31);
			y_dct[i][j*32 + 24] = x_34[i][j*32 + 0] - x_82[i][i*32 + 1] + x_84[i][j*32 + 2] - x_38[i][j*32 + 3] - x_30[i][j*32 + 4] + x_80[i][j*32 + 5] - x_85[i][j*32 + 6] + x_42[i][j*32 + 7] + x_26[i][j*32 +  8] - x_78[i][j*32 +  9] + x_86[i][j*32 + 10] - x_46[i][j*32 + 11] - x_21[i][j*32 + 12] + x_77[i][j*32 + 13] - x_87[i][j*32 + 14] + x_50[i][j*32 + 15] + x_17[i][j*32 + 16] - x_74[i][j*32 + 17] + x_88[i][j*32 + 18] - x_53[i][j*32 + 19] - x_13[i][j*32 + 20] + x_72[i][j*32 + 21] - x_89[i][j*32 + 22] + x_56[i][j*32 + 23] + x_9 [i][j*32 + 24] - x_68[i][j*32 + 25] + x_90[i][j*32 + 26] - x_60[i][j*32 + 27] - x_4 [i][j*32 + 28] + x_66[i][j*32 + 29] - x_90(i*32 + 30) + x_63(i*32 + 31);
			y_dct[i][j*32 + 25] = x_30[i][j*32 + 0] - x_77[i][i*32 + 1] + x_89[i][j*32 + 2] - x_63[i][j*32 + 3] + x_9 [i][j*32 + 4] + x_50[i][j*32 + 5] - x_85[i][j*32 + 6] + x_84[i][j*32 + 7] - x_46[i][j*32 +  8] - x_13[i][j*32 +  9] + x_66[i][j*32 + 10] - x_90[i][j*32 + 11] + x_74[i][j*32 + 12] - x_26[i][j*32 + 13] - x_34[i][j*32 + 14] + x_78[i][j*32 + 15] - x_88[i][j*32 + 16] + x_60[i][j*32 + 17] - x_4 [i][j*32 + 18] - x_53[i][j*32 + 19] + x_86[i][j*32 + 20] - x_82[i][j*32 + 21] + x_42[i][j*32 + 22] + x_17[i][j*32 + 23] - x_68[i][j*32 + 24] + x_90[i][j*32 + 25] - x_72[i][j*32 + 26] + x_21[i][j*32 + 27] + x_38[i][j*32 + 28] - x_80[i][j*32 + 29] + x_87(i*32 + 30) - x_56(i*32 + 31);
			y_dct[i][j*32 + 26] = x_26[i][j*32 + 0] - x_68[i][i*32 + 1] + x_89[i][j*32 + 2] - x_80[i][j*32 + 3] + x_46[i][j*32 + 4] + x_4 [i][j*32 + 5] - x_53[i][j*32 + 6] + x_84[i][j*32 + 7] - x_87[i][j*32 +  8] + x_63[i][j*32 +  9] - x_17[i][j*32 + 10] - x_34[i][j*32 + 11] + x_74[i][j*32 + 12] - x_90[i][j*32 + 13] + x_77[i][j*32 + 14] - x_38[i][j*32 + 15] - x_13[i][j*32 + 16] + x_60[i][j*32 + 17] - x_86[i][j*32 + 18] + x_85[i][j*32 + 19] - x_56[i][j*32 + 20] + x_9 [i][j*32 + 21] + x_42[i][j*32 + 22] - x_78[i][j*32 + 23] + x_90[i][j*32 + 24] - x_72[i][j*32 + 25] + x_30[i][j*32 + 26] + x_21[i][j*32 + 27] - x_66[i][j*32 + 28] + x_88[i][j*32 + 29] - x_82(i*32 + 30) + x_50(i*32 + 31);
			y_dct[i][j*32 + 27] = x_21[i][j*32 + 0] - x_60[i][i*32 + 1] + x_84[i][j*32 + 2] - x_89[i][j*32 + 3] + x_74[i][j*32 + 4] - x_42[i][j*32 + 5] + x_42[i][j*32 + 7] - x_74[i][j*32 + 8] + x_89[i][j*32 +  9] - x_84[i][j*32 + 10] + x_60[i][j*32 + 11] - x_21[i][j*32 + 12] - x_21[i][j*32 + 13] + x_60[i][j*32 + 14] - x_84[i][j*32 + 15] + x_89[i][j*32 + 16] - x_74[i][j*32 + 17] + x_42[i][j*32 + 18] - x_42[i][j*32 + 20] + x_74[i][j*32 + 21] - x_89[i][j*32 + 22] + x_84[i][j*32 + 23] - x_60[i][j*32 + 24] + x_21[i][j*32 + 25] + x_21[i][j*32 + 26] - x_60[i][j*32 + 27] + x_84[i][j*32 + 28] - x_89[i][j*32 + 29] + x_74[i][j*32 + 30] - x_42[i][j*32 + 31];
			y_dct[i][j*32 + 28] = x_17[i][j*32 + 0] - x_50[i][i*32 + 1] + x_74[i][j*32 + 2] - x_87[i][j*32 + 3] + x_88[i][j*32 + 4] - x_77[i][j*32 + 5] + x_53[i][j*32 + 6] - x_21[i][j*32 + 7] - x_13[i][j*32 +  8] + x_46[i][j*32 +  9] - x_72[i][j*32 + 10] + x_86[i][j*32 + 11] - x_89[i][j*32 + 12] + x_78[i][j*32 + 13] - x_56[i][j*32 + 14] + x_26[i][j*32 + 15] + x_9 [i][j*32 + 16] - x_42[i][j*32 + 17] + x_68[i][j*32 + 18] - x_85[i][j*32 + 19] + x_90[i][j*32 + 20] - x_80[i][j*32 + 21] + x_60[i][j*32 + 22] - x_30[i][j*32 + 23] - x_4 [i][j*32 + 24] + x_38[i][j*32 + 25] - x_66[i][j*32 + 26] + x_84[i][j*32 + 27] - x_90[i][j*32 + 28] + x_82[i][j*32 + 29] - x_63(i*32 + 30) + x_34(i*32 + 31);
			y_dct[i][j*32 + 29] = x_13[i][j*32 + 0] - x_38[i][i*32 + 1] + x_60[i][j*32 + 2] - x_77[i][j*32 + 3] + x_86[i][j*32 + 4] - x_90[i][j*32 + 5] + x_85[i][j*32 + 6] - x_74[i][j*32 + 7] + x_56[i][j*32 +  8] - x_34[i][j*32 +  9] + x_9 [i][j*32 + 10] + x_17[i][j*32 + 11] - x_42[i][j*32 + 12] + x_63[i][j*32 + 13] - x_78[i][j*32 + 14] + x_87[i][j*32 + 15] - x_90[i][j*32 + 16] + x_84[i][j*32 + 17] - x_72[i][j*32 + 18] + x_53[i][j*32 + 19] - x_30[i][j*32 + 20] + x_4 [i][j*32 + 21] + x_21[i][j*32 + 22] - x_46[i][j*32 + 23] + x_66[i][j*32 + 24] - x_80[i][j*32 + 25] + x_88[i][j*32 + 26] - x_89[i][j*32 + 27] + x_82[i][j*32 + 28] - x_68[i][j*32 + 29] + x_50(i*32 + 30) - x_26(i*32 + 31);
			y_dct[i][j*32 + 30] = x_9 [i][j*32 + 0] - x_26[i][i*32 + 1] + x_42[i][j*32 + 2] - x_56[i][j*32 + 3] + x_68[i][j*32 + 4] - x_78[i][j*32 + 5] + x_85[i][j*32 + 6] - x_89[i][j*32 + 7] + x_90[i][j*32 +  8] - x_86[i][j*32 +  9] + x_80[i][j*32 + 10] - x_72[i][j*32 + 11] + x_60[i][j*32 + 12] - x_46[i][j*32 + 13] + x_30[i][j*32 + 14] - x_13[i][j*32 + 15] - x_4 [i][j*32 + 16] + x_21[i][j*32 + 17] - x_38[i][j*32 + 18] + x_53[i][j*32 + 19] - x_66[i][j*32 + 20] + x_77[i][j*32 + 21] - x_84[i][j*32 + 22] + x_88[i][j*32 + 23] - x_90[i][j*32 + 24] + x_87[i][j*32 + 25] - x_82[i][j*32 + 26] + x_74[i][j*32 + 27] - x_63[i][j*32 + 28] + x_50[i][j*32 + 29] - x_34(i*32 + 30) + x_17(i*32 + 31);
			y_dct[i][j*32 + 31] = x_4 [i][j*32 + 0] - x_13[i][i*32 + 1] + x_21[i][j*32 + 2] - x_30[i][j*32 + 3] + x_38[i][j*32 + 4] - x_46[i][j*32 + 5] + x_53[i][j*32 + 6] - x_60[i][j*32 + 7] + x_66[i][j*32 +  8] - x_72[i][j*32 +  9] + x_77[i][j*32 + 10] - x_80[i][j*32 + 11] + x_84[i][j*32 + 12] - x_86[i][j*32 + 13] + x_88[i][j*32 + 14] - x_90[i][j*32 + 15] + x_90[i][j*32 + 16] - x_89[i][j*32 + 17] + x_87[i][j*32 + 18] - x_85[i][j*32 + 19] + x_82[i][j*32 + 20] - x_78[i][j*32 + 21] + x_74[i][j*32 + 22] - x_68[i][j*32 + 23] + x_63[i][j*32 + 24] - x_56[i][j*32 + 25] + x_50[i][j*32 + 26] - x_42[i][j*32 + 27] + x_34[i][j*32 + 28] - x_26[i][j*32 + 29] + x_17(i*32 + 30) - x_9 (i*32 + 31);
    }
    */

    return 0;
}
