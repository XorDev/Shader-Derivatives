///@desc Draw demos

//Cycle throw demos
demo += mouse_check_button_pressed(mb_left);

var _time = get_timer()/1000000;
var _head = "";
var _text = "";

switch(demo%3)
{
	//Emboss demo
	case 0:
	_head = "Emboss shader";
	var _mode = ["dFdx","dFdy","fwidth","input"];
	_text = "Mode: "+_mode[_time/2 % 4];
	
	shader_set(shd_1_emboss);
	shader_set_uniform_f(uni_time,_time);
	draw_sprite_ext(spr_xor,0,640,360,1,1,0*current_time/70,-1,1);
	shader_reset();
	break;

	//AA demo
	case 1:
	_head = "Antialiasing shader";
	_text = "Computes AA on any quad";
	
	var _cos = .5*cos(_time*1.4);
	
	shader_set(shd_2_antialias);
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_texture(0200,100,0,0);
	draw_vertex_texture(1000,100,1,0);
	draw_vertex_texture(0200,550,0,1);
	draw_vertex_texture(1000+380*_cos,550+170*_cos,1,1);
	draw_primitive_end();
	shader_reset();
	
	//Quad wireframe
	if (_time%3>2)
	{
		draw_set_alpha(.5);
		draw_primitive_begin(pr_linestrip);
		draw_vertex(1000,100);
		draw_vertex(0200,100);
		draw_vertex(0200,550);
		draw_vertex(1000+380*_cos,550+170*_cos);
		draw_vertex(1000,100);
		draw_primitive_end();
		draw_set_alpha(1);
	}
	break;

	//Normal mapping demo
	case 2:
	_head = "Normal mapping shader";
	_text = "Works with transformations";
	shader_set(shd_3_normalmap);
	shader_set_uniform_f(uni_pos,mouse_x,mouse_y,room_width*0.1);
	draw_sprite_ext(spr_rock_normal,0,640,360,1,1,current_time/70,-1,1);
	shader_reset();
	break;
}

draw_set_font(fnt_header);
draw_text(48,48,_head);
draw_set_font(fnt_body);
draw_text(48,88,_text)
draw_text(48,room_height-88,"Click to continue");