/*
.set("size",width,height);
.set("time",frameCount);
.set("param",split);
*/

uniform sampler2D texture;
uniform sampler2D tex;
uniform ivec2 size;
uniform ivec2 e0;
uniform ivec2 e1;
uniform ivec2 e2;
uniform ivec2 e3;

void main()
{

	e0.y=size.y-e0.y;
	e1.y=size.y-e1.y;
	e2.y=size.y-e2.y;
	e3.y=size.y-e3.y;
	if((gl_FragCoord.x-e0.x)/(e3.x-e0.x)*(e3.y-e0.y)>(gl_FragCoord.y-e0.y))
	{
		mat2 m0=mat2((e3.x-e2.x)*1./size.x,(e3.y-e2.y)*1./size.x,(e0.x-e2.x)*1./size.y,(e0.y-e2.y)*1./size.y);
		vec2 p=inverse(m0)*vec2(gl_FragCoord.xy-vec2(e2));
		if(0<p.x&&p.x<size.x&&0<p.y&&p.y<size.y&&texelFetch(tex,ivec2(p.x,size.y-p.y)*textureSize(tex,0)/size,0).w>.2)
		{
			gl_FragColor=texelFetch(tex,ivec2(p.x,size.y-p.y)*textureSize(tex,0)/size,0);
		}else{
			gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
		}
	}else{
		ivec2 ofs=ivec2(e3.x+e0.x-e1.x,e3.y+e0.y-e1.y);
		mat2 m0=mat2((e3.x-ofs.x)*1./size.x,(e3.y-ofs.y)*1./size.x,(e0.x-ofs.x)*1./size.y,(e0.y-ofs.y)*1./size.y);
		vec2 p=inverse(m0)*vec2(gl_FragCoord.xy-ofs);
		gl_FragColor=texelFetch(texture,ivec2(p),0);
		if(0<p.x&&p.x<size.x&&0<p.y&&p.y<size.y&&texelFetch(tex,ivec2(p.x,size.y-p.y)*textureSize(tex,0)/size,0).w>.2)
		{
			gl_FragColor=texelFetch(tex,ivec2(p.x,size.y-p.y)*textureSize(tex,0)/size,0);
		}else{
			gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
		}
	}
}