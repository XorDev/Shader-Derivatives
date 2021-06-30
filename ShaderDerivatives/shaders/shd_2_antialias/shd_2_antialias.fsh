//This extension adds three functions: dFdx, dFdy, fwidth
#extension GL_OES_standard_derivatives : require
//Will cause an error if your hardware doesn't support it!
//Note: Some platforms have little or no support (like Apple) so you may need alternatives.

//Read the emboss fragment shader first!

varying vec2 v_coord;

void main()
{
	//Distance to center of texture coordinates.
	float dist = .5-length(v_coord-.5);
	//Find the x,y change in dist
	float dx = dFdx(dist);
	float dy = dFdy(dist);
	
	//Use the derivative to find the texel width
	float width = fwidth(dist);
	//Better alternative:
	//width = length(vec2(dx,dy));
	//Demonstration: https://www.shadertoy.com/view/7dfGR4
	
	//Divide the distance by texel width (to bring back to pixel range)
	dist /= width;
    gl_FragColor = vec4(.6,.8,1, clamp(dist,0.,1.));
}
