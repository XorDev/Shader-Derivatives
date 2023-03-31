//This uses the "GL_OES_standard_derivatives" extension which adds three functions: dFdx, dFdy, fwidth
//#extension GL_OES_standard_derivatives : require
//Update 2023: Extension is enabled by default.
//Will cause an error if your hardware doesn't support it!
//Note: Some platforms have little or no support (like Apple) so you may need alternatives.

//The fragment shader doesn't run one pixel at a time. It computes in 2x2 quad sections.
//This means the shader actually knows a little bit about some of the pixels around it.
//With the derivatives extension, you can find the difference between two pixels.

//Let's say you have 4 pixels (2x2), with values labeled v1-v4:
// v1, v2
// v3, v4

//dFdx(p) returns v2-v1 or v4-v3 depending on if the pixel is on the top-half or bottom.
//dFdy(p) returns v3-v1 or v4-v2 depending on the left or right side of the quad.
//fwidth(p) returns abs(dFdx(p)) + abs(dFdy(p)), or in other words the total x and y differences.
//This difference is known as a "derivative" which is a much bigger topic. Feel free to read up on it.

//gl_FragCoord is the screen pixel coordinates, so dFdx(gl_Fragcoord.x) = 1.0.
//That's because the gl_FragCoord x-coordinate increases value by 1 for each pixel.

//In this shader we use derivatives to create various edge detection effects with only one texture sample!

varying vec4 v_color;
varying vec2 v_coord;

uniform float time;

void main()
{
	//Sample the texture like normal.
	vec4 tex = v_color * texture2D(gm_BaseTexture, v_coord);
	//Mode cycle for demonstrating the different functions.
	float mode = mod(time/2.,4.);
	
	if (mode<1.)
	{
		//Compute the x-derivative of the texture.
		//Add 0.5 to balance between positive and negative.
		tex.rgb = dFdx(length(tex.rgb))+vec3(.5);
	}
	else if (mode<2.)
	{
		//Compute the y-derivative of the texture.
		tex.rgb = dFdy(tex.rgb)+.5;
	}
	else if (mode<3.)
	{
		//Compute x and y derivative.
		tex.rgb = fwidth(tex.rgb);
	}
	
    gl_FragColor = tex;
}
