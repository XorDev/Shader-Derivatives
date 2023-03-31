//This uses the "GL_OES_standard_derivatives" extension which adds three functions: dFdx, dFdy, fwidth
//#extension GL_OES_standard_derivatives : require
//Update 2023: Extension is enabled by default.
//Will cause an error if your hardware doesn't support it!
//Note: Some platforms have little or no support (like Apple) so you may need alternatives.

//Read the emboss fragment shader first!

varying vec2 v_coord;

void main()
{
	//Distance to center of texture coordinates.
	float dist = 0.5 - length(v_coord - 0.5);
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
    gl_FragColor = vec4(0.6,0.8,1.0, clamp(dist,0.,1.));
}
