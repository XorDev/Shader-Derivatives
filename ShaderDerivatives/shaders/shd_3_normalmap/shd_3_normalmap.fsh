//This extension adds three functions: dFdx, dFdy, fwidth
#extension GL_OES_standard_derivatives : require

varying vec4 v_color;
varying vec2 v_coord;

uniform vec3 pos;

void main()
{
	vec4 tex = texture2D(gm_BaseTexture, v_coord);
	vec3 normal = normalize(tex.rgb-.5);
	//Compute the texture coordinates derivatives.
	vec2 dx = dFdx(v_coord);
	vec2 dy = dFdy(v_coord);
	vec4 rot = vec4(dx,dy);
	//Correct normal with texture orientation.
	normal.xy *= mat2(normalize(rot.xz),normalize(rot.yw));
	
	//Difference from surface to light position.
	vec3 dir = normalize(pos-gl_FragCoord.xyz);
	//Compute lambertian lighting.
	float lambert = max(dot(normal,dir),0.);
	//Compute light color.
	vec3 light = pow(vec3(lambert), vec3(1, 1.5, 2));
    gl_FragColor = v_color * vec4(light,1);
}