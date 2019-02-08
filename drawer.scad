//color([1,0,0]) cube([2,3,4]);
//translate([3,0,0]) {
//   cube([2,3,4]);
//}

/*for(i=[0:36]) {
    for(j=[0:36]) {
      color( [0.5+sin(10*i)/2, 0.5+sin(10*j)/2, 0.5+sin(10*(i+j))/2] )
      translate( [i, j, 0] )
      cube( size = [1, 1, 11+10*cos(10*i)*sin(10*j)] );
    }
  }*/
//legHeight = 70;





/*
cube([10,10,legHeight]);

translate([190,0,0])cube([10,10,legHeight]);

 translate([-100,40,0])cube([10,10,legHeight]);

 translate([-100,-50,0])cube([10,10,legHeight]); 
 
translate([0,0,legHeight]) {
    difference(){
      cube([200,100,30]);
      
        
        //translate([10,10,6])  //cube([180,80,25]);
}
}*/


module createDrawer (width,height,depth, thickness)
{
    //translate([width*$t,0,0]) {
        //bottom
        color("red") cube([width,depth,thickness/2]);
        //back
        cube([thickness/2,depth,height]);
        //side1
        cube([width,thickness/2,height]);
        //side2
        translate([0,depth-thickness/2,0]){
            cube([width,thickness/2,height]);
        }
        //top
        translate([thickness/2,thickness/2,height]){
            
            
           
            
            
            
            if($t < 0.1){
                color("green") outerLid(width,height,depth,thickness,$t*10,1);
                color("yellow") innerLid(width,height,depth,thickness,0);
            }else if( $t < 0.2){
                color("green") outerLid(width,height,depth,thickness,1,1);
                color("yellow") innerLid(width,height,depth,thickness,0);
            }else if($t < 0.3){
                color("green") outerLid(width,height,depth,thickness,1-($t-0.2)*10,1);
                color("yellow") innerLid(width,height,depth,thickness,0);
            }else if($t < 0.4){
                color("green") outerLid(width,height,depth,thickness,0);
                color("yellow") innerLid(width,height,depth,thickness,0);
            }else if($t < 0.5){
                color("green") outerLid(width,height,depth,thickness, ($t-0.4)*10);
                color("yellow") innerLid(width,height,depth,thickness,($t-0.4)*10);//($t*10)-1);
            }else if($t < 0.6){
                color("green") outerLid(width,height,depth,thickness,1,($t-0.5)*10);
                color("yellow") innerLid(width,height,depth,thickness,1);
            }else if($t < 0.7){
                color("green") outerLid(width,height,depth,thickness,1,1);
                color("yellow") innerLid(width,height,depth,thickness,1-($t-0.6)*10);
            }else {
                color("green") outerLid(width,height,depth,thickness,1,1);
                color("yellow") innerLid(width,height,depth,thickness,0);
            }
        }
        //front
        translate([width,0,0]){
                    cube([thickness/2,depth,height]);

        }
    //}
}
createDrawer(25,7,40,1);

module outerLid(width,height,depth,thickness,opened,knobRot){
    rotate([0,-130*opened,0]){
        difference(){
            translate([0,0,-thickness/2]){
                cube([width-thickness/2,depth-thickness,thickness/2]);
                translate([0,thickness/2,-thickness/2]){
                    cube([thickness,depth-2*thickness,thickness/2]);
                }
                translate([0,thickness/2,-thickness]){
                    cube([2*thickness,depth-2*thickness,thickness/2]);
                }
                
                /*translate([width-2*thickness,(depth-thickness)/2,thickness]){
                    sphere(1);
                }*/
            }
            translate([width-2*thickness,(depth-thickness)/2,-thickness-0.1]){
                    cylinder(20,0.52,0.52);
            }
            
        }
        //knob
        translate([width-2*thickness,(depth-thickness)/2,1.5*thickness]){
            sphere(1, $fn=100);
            rotate([0,0,90*knobRot]){
                union(){
                translate([0,0,-3*thickness]){
                    cylinder(3,0.52,0.5, $fn=100);
                }
                translate([-thickness+0.2,-thickness/4,-3*thickness]){
                        cube([0.5,0.5,0.5]);
                }
                }
            }
        }
        
    }
        
    
}
module innerLid(width,height,depth,thickness,opened){
    rotate([0,-130*opened,0]){
        difference(){
            translate([0.2,0,-thickness]){
                difference(){
                cube([width-thickness/2,depth-thickness,thickness/2]);
                translate([-0.1,thickness*1/4,-0.1]){
                    cube([2*thickness+0.2,depth-2*thickness,thickness+0.2]);
                }
                
                }
            }
            translate([width-2*thickness,(depth-thickness)/2,-thickness-0.1]){
                        cylinder(20,0.52,0.52, $fn=100);
            }
            translate([width-2*thickness-0.2,(depth-thickness)/2-thickness+0.1,-thickness-0.1]){
                        cube([0.5,0.5,1]);
            }
            
        }
        translate([width-2*thickness+0.3,(depth-thickness)/2-thickness+0.1,-1.5*thickness]){
                        cube([0.5,0.5,0.5]);
        }
        translate([width-3*thickness,(depth-thickness)/2+thickness/4,-1.5*thickness]){
                        cube([0.5,0.5,0.5]);
        }
        
    }
}
