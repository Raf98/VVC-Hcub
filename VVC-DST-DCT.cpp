#include <cstdio>
#include <cstdlib>
#include <stdbool.h>
#include <cstring>
#include <cmath>

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

//--------------------------------------------------------------------------------------------------


void printMatrix (int n, int trCore[][32], bool includeAmpersand) {
  for (int i = 0; i < n; i++) {
    //printf("{");
    for (int j = 0; j < n; j++) {
      printf("%d", trCore[i][j]);
      if (j != n - 1) includeAmpersand == true ? printf(" & ") : printf(" ");
    }
    //printf("}");
    if (includeAmpersand == true) printf(" \\\\");
    printf("\n");
  }
}

void concatInput(char* str, char* numberStr, int rowIndex, int matrixNumber) {
  strcat(str, "x");
  strcat(str, "_");
  sprintf(numberStr, "%d", abs(matrixNumber));
  strcat(str, numberStr);
  
  strcat(str, "(i*8 + ");
  sprintf(numberStr, "%d", rowIndex);
  strcat(str, numberStr);
  strcat(str, ")");
}


void printInputsToSignals (int n) {
  char str[20];
  char numberStr[10];
  char inputStr[32][500];
  
  for (int i = 0; i < n; ++i) {
    strcpy(inputStr[i], "");
  }
  
  int countInputs = 0;
  int j = 0;
  for (int i = 0; i < n * n; ++i) {
    strcpy(str, "");
    strcat(str, "x(");
    sprintf(numberStr, "%d", i);
    strcat(str, numberStr);
  
    strcat(str, ") <= x");
    sprintf(numberStr, "%d", i);
    strcat(str, numberStr);
    strcat(str, ";");
    
    printf("%s\n", str);
    
    strcat(inputStr[j], "x");
    strcat(inputStr[j], numberStr);
    
    if (countInputs == n - 1) {
      strcat(inputStr[j], ": in std_logic_vector(inBits - 1 downto 0);");
      //printf("%s\n", inputStr);
      countInputs = 0;
      ++j;
      //strcpy(inputStr, "");
    } else {
      strcat(inputStr[j], ", ");
      ++countInputs;
    }
  }
  
  for (int i = 0; i < n; ++i) {
    printf("%s\n", inputStr[i]);
  }
}

void printOutputsOperations (int n, int trCore[][32]) {
  char str[600];
  char inputs[10];
  char numberStr[8];
  
  strcpy(inputs, "");
  
  for (int j = 0; j < n; ++j) {
    
    strcpy(str, "y(i*8 + ");
    sprintf(numberStr, "%d", j);
    strcat(str, numberStr);
    strcat(str, ") <= ");
    
    
    
    for (int i = 0; i < n; i++) {
      if ( i > 0 && trCore[i][j] > 0 ) {
        strcat(str, " + ");
      } else if ( trCore[i][j] < 0 ) {
        strcat(str, " - ");
      } else if ( trCore[i][j] == 0 ) {
        continue;
      }
    
      concatInput(str, numberStr, i, trCore[i][j]);
    }
    printf("%s;\n", str);
  }
  
  //printf("%s\n", inputs);
}

void printSignalsToOutputs (int n) {
  char str[20];
  char numberStr[10];
  char outputStr[32][5000];
  
  for (int i = 0; i < n; ++i) {
    strcpy(outputStr[i], "");
  }
  
  int countOutputs = 0;
  int j = 0;
  for (int i = 0; i < n * n; ++i) {
    strcpy(str, "");
    strcat(str, "y");
    sprintf(numberStr, "%d", i);
    strcat(str, numberStr);
  
    strcat(str, " <= y(");
    sprintf(numberStr, "%d", i);
    strcat(str, numberStr);
    strcat(str, ");");
    
    printf("%s\n", str);
    
    strcat(outputStr[j], "y");
    strcat(outputStr[j], numberStr);
    
    if (countOutputs == n - 1) {
      strcat(outputStr[j], ": out std_logic_vector(outBits - 1 downto 0);");
      //printf("%s\n", outputStr);
      countOutputs = 0;
      ++j;
    } else {
      strcat(outputStr[j], ", ");
      ++countOutputs;
    }
  }
  
  for (int i = 0; i < n; ++i) {
    printf("%s\n", outputStr[i]);
  }
}


int main( int argc, char *argv[] ) {

   int n = 4;
   bool includeAmpersand = false;
   
   if (argc > 1 &&  atoi(argv[1]) == 1) includeAmpersand = true;
   
   printf("-------------PRINTING DCT-VIII MATRICES--------------------\n");
   printf("DCT-VIII 4x4:\n");
   printMatrix(4, trCoreDCT8P4, includeAmpersand);
   printf("\n");
   printf("DCT-VIII 8x8:\n");
   printMatrix(8, trCoreDCT8P8, includeAmpersand);
   printf("\n");
   printf("DCT-VIII 16x16:\n");
   printMatrix(16, trCoreDCT8P16, includeAmpersand);
   printf("\n");
   printf("DCT-VIII 32x32:\n");
   printMatrix(32, trCoreDCT8P32, includeAmpersand);
   printf("\n");
   
   printf("-------------PRINTING DST-VII MATRICES--------------------\n");
   printf("DST-VII 4x4:\n");
   printMatrix(4, trCoreDST7P4, includeAmpersand);
   printf("\n");
   printf("DST-VII 8x8:\n");
   printMatrix(8, trCoreDST7P8, includeAmpersand);
   printf("\n");
   printf("DST-VII 16x16:\n");
   printMatrix(16, trCoreDST7P16, includeAmpersand);
   printf("\n");
   printf("DST-VII 32x32:\n");
   printMatrix(32, trCoreDST7P32, includeAmpersand);
   printf("\n");
   
   printf("-------------PRINTING DCT-VIII INPUTS TO SIGNALS--------------------\n");
   printf("DCT-VIII 4x4:\n");
   printInputsToSignals(4);
   printf("\n");
   printf("DCT-VIII 8x8:\n");
   printInputsToSignals(8);
   printf("\n");
   printf("DCT-VIII 16x16:\n");
   printInputsToSignals(16);
   printf("\n");
   printf("DCT-VIII 32x32:\n");
   printInputsToSignals(32);
   printf("\n");
   
   printf("-------------PRINTING DCT-VIII OUTPUTS OPS--------------------\n");
   printf("DCT-VIII 4x4:\n");
   printOutputsOperations(4, trCoreDCT8P4);
   printf("\n");
   printf("DCT-VIII 8x8:\n");
   printOutputsOperations(8, trCoreDCT8P8);
   printf("\n");
   printf("DCT-VIII 16x16:\n");
   printOutputsOperations(16, trCoreDCT8P16);
   printf("\n");
   printf("DCT-VIII 32x32:\n");
   printOutputsOperations(32, trCoreDCT8P32);
   printf("\n");
   
   printf("-------------PRINTING DCT-VIII SIGNALS TO OUTPUTS--------------------\n");
   printf("DCT-VIII 4x4:\n");
   printSignalsToOutputs(4);
   printf("\n");
   printf("DCT-VIII 8x8:\n");
   printSignalsToOutputs(8);
   printf("\n");
   printf("DCT-VIII 16x16:\n");
   printSignalsToOutputs(16);
   printf("\n");
   printf("DCT-VIII 32x32:\n");
   printSignalsToOutputs(32);
   printf("\n");
   
   printf("-------------PRINTING DST-VII INPUTS TO SIGNALS--------------------\n");
   printf("DST-VII 4x4:\n");
   printInputsToSignals(4);
   printf("\n");
   printf("DST-VII 8x8:\n");
   printInputsToSignals(8);
   printf("\n");
   printf("DST-VII 16x16:\n");
   printInputsToSignals(16);
   printf("\n");
   printf("DST-VII 32x32:\n");
   printInputsToSignals(32);
   printf("\n");
   
   printf("-------------PRINTING DST-VII OUTPUTS OPS--------------------\n");  
   printf("DST-VII 4x4:\n");
   printOutputsOperations(4, trCoreDST7P4);
   printf("\n");
   printf("DST-VII 8x8:\n");
   printOutputsOperations(8, trCoreDST7P8);
   printf("\n");
   printf("DST-VII 16x16:\n");
   printOutputsOperations(16, trCoreDST7P16);
   printf("\n");
   printf("DST-VII 32x32:\n");
   printOutputsOperations(32, trCoreDST7P32);
   printf("\n");
   
   printf("-------------PRINTING DST-VII SIGNALS TO OUTPUTS--------------------\n");
   printf("DST-VII 4x4:\n");
   printSignalsToOutputs(4);
   printf("\n");
   printf("DST-VII 8x8:\n");
   printSignalsToOutputs(8);
   printf("\n");
   printf("DST-VII 16x16:\n");
   printSignalsToOutputs(16);
   printf("\n");
   printf("DST-VII 32x32:\n");
   printSignalsToOutputs(32);
   printf("\n");
}
