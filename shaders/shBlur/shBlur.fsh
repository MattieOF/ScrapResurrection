// Code from https://stackoverflow.com/questions/64837705/opengl-blurring
// Edited to use GM things and also fixed it being weird

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float xs, ys;
uniform float r;
uniform int axis;

void main()
{
	float x,y,xx,yy,rr=r*r,dx,dy,w,w0;
    w0=0.3780/pow(r,1.975);
    vec2 p;
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    for (dx=1.0/xs,x=-r,p.x=v_vTexcoord.x+(x*dx);x<=r;x++,p.x+=dx){ xx=x*x;
     for (dy=1.0/ys,y=-r,p.y=v_vTexcoord.y+(y*dy);y<=r;y++,p.y+=dy){ yy=y*y;
      if (xx+yy<=rr)
        {
        w=w0*exp((-xx-yy)/(2.0*rr));
        col+=texture2D(gm_BaseTexture,p)*w;
        }}}
    gl_FragColor=col;
}

