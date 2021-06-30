///@desc Initialize

demo = 0;

//Maximize anti-aliasing
aa = max(display_aa&1,display_aa&2,display_aa&4,display_aa&8);
display_reset(aa,0);
//And linear texture filtering.
gpu_set_tex_filter(1);

//Uniforms.
uni_time = shader_get_uniform(shd_1_emboss,"time");
uni_pos = shader_get_uniform(shd_3_normalmap,"pos");