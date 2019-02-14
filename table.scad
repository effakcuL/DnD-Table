drawerHeight = 10;
drawerWidth = 40;
drawerDepth = 18;
drawerOverlap = 12;
wallThickness = 1;
maxStep = 8;
tableHeight = 80;


translate([1,10,tableHeight-drawerHeight-5])
difference() {
    *cube([wallThickness,160,drawerHeight+5]);

    translate([0,-50,2.5]){
        
        for(numDrawers = [1:3]){
           * translate([-0.1,55*numDrawers,0]) cube([drawerDepth,drawerWidth,drawerHeight]);
        }
    
    }
}

translate([drawerDepth+drawerOverlap,0,tableHeight-drawerHeight-2.5]) rotate([0,0,180]) {
    //for(numDrawers = [1:3]){
        translate([0,-60,0]) rotate([0,0,30])createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
        translate([2,-110,0]) createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
        translate([-18,-150,0]) rotate([0,0,-30])createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);


    //}
}
translate([drawerDepth+drawerOverlap,0,tableHeight-drawerHeight-2.5]) translate([40,185,0])rotate([0,0,0]) {
    //for(numDrawers = [1:3]){
        translate([2,-70,0]) rotate([0,0,30])createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
        translate([3,-115,0]) createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
        translate([-20,-160,0]) rotate([0,0,-30])createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);


    //}
}



createDMScreen();
tableTop();

/*
//Regular Legs
cube([10,10,100]);
translate([0,170,0])cube([10,10,100]);
translate([90,170,0])cube([10,10,100]);
translate([90,0,0])cube([10,10,100]);
*/

//Fancy Leg
translate([20,10,0])cube([60,20,5]);
translate([40,30,0]) cube([20,120,5]);
translate([20,150,0]) cube([60,20,5]);
translate([40,80,5]) cube([20,20,tableHeight -5]);




/*
translate([99,10,100-drawerHeight-5])
difference() {
    cube([wallThickness,160,drawerHeight+5]);

    translate([0,-50,2.5]){
    for(numDrawers = [1:3]){
        translate([-0.1,55*numDrawers,0]) cube([drawerDepth,drawerWidth,drawerHeight]);
    }
    }
}

translate([100-(drawerDepth+drawerOverlap),180,100-drawerHeight-2.5]) rotate([0,0,0]) {
    for(numDrawers = [1:3]){
        translate([0,-55*numDrawers,0]) createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
}*/



module tableTop(){
    translate([0,0,tableHeight])
    difference(){
        cube([100,180,3]);
        translate([0,57,-1])rotate([0,0,-60])translate([0,-40,0])cube([66,40,5]);
        translate([0,180-57,-1])rotate([0,0,60])translate([0,,0])cube([66,40,5]);
    
        translate([100,57,-1])rotate([0,0,180+60])translate([0,0,0])cube([66,40,5]);
        translate([100,180-57,-1])rotate([0,0,120])translate([0,-40,0])cube([66,40,5]);
    
    }
}
    
    
module createDrawer (width,height,depth,thickness,overlap){
        translate([(width+overlap-10)*min($t*maxStep,1),0,0]) {
            //bottom
            color("red") cube([width+overlap,depth,thickness/2]);
            //back
            cube([thickness/2,depth,height]);
            //side1
            cube([width+overlap,thickness/2,height]);
            //side2
            translate([0,depth-thickness/2,0]){
                cube([width+overlap,thickness/2,height]);
            }
            //top
            
            translate([thickness/2,thickness/2,height-thickness])cube([overlap,depth-thickness,thickness]);
            
            translate([overlap,0,0])
            
            
            translate([thickness/2,thickness/2,height]){
               
                      if($t < 1/maxStep){ //Open outer lid
                    color("green") outerLid(width,height,depth,thickness,0 ,1);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 2/maxStep){ //Open outer lid
                    color("green") outerLid(width,height,depth,thickness, ($t - 1/maxStep)*maxStep ,1);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 3/maxStep){ //outer lid open
                    color("green") outerLid(width,height,depth,thickness,1,1);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 4/maxStep){ //close outer lid
                    color("green") outerLid(width,height,depth,thickness,1-( $t - 3/maxStep)*maxStep,1);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 5/maxStep){ //both lids closed
                    color("green") outerLid(width,height,depth,thickness,0);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 6/maxStep){ //open both lids
                    color("green") outerLid(width,height,depth,thickness, ($t-5/maxStep)*maxStep);
                    color("yellow") innerLid(width,height,depth,thickness,($t-5/maxStep)*maxStep);
                }else if($t < 7/maxStep){ //turn knob
                    color("green") outerLid(width,height,depth,thickness,1,($t-6/maxStep)*maxStep);
                    color("yellow") innerLid(width,height,depth,thickness,1);
                }else if($t < 8/maxStep){ //close inner lid
                    color("green") outerLid(width,height,depth,thickness,1,1);
                    color("yellow") innerLid(width,height,depth,thickness,1-($t-7/maxStep)*maxStep);
                }else if($t < 9/maxStep){
                    color("green") outerLid(width,height,depth,thickness,1,1);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }
            }
           
            //front
            translate([width+overlap,0,0]){
                        cube([thickness/2,depth,height]);
            }
        }
    }
    

module outerLid(width,height,depth,thickness,opened,knobRot){
    
    translate([thickness,0,-thickness/2]){
    rotate([0,-130*opened,0]){
        rotate([-90,0,0]) translate([0,0,thickness/2]){
            difference(){
            cylinder(depth-2*thickness,thickness+0.1,thickness+0.1, $fn=50);
            translate([thickness*1/3+0.1,0,-0.005]) cube([thickness*2/3,thickness*2/3,depth-2*thickness+0.01]);
            translate([-thickness,-2*thickness,-0.005])cube([2*thickness,2*thickness,depth-2*thickness+0.01]);
            }
        }
        translate([-thickness,0,thickness/2]){
        
        difference(){
            translate([0,0,-thickness/2]){
                cube([width-thickness/2,depth-thickness,thickness/2]);
            }
            translate([width-2*thickness,(depth-thickness)/2,-thickness-0.1]){
                    cylinder(2,0.52,0.52);
            }
            
        }
        //knob
        translate([width-2*thickness,(depth-thickness)/2,1.5*thickness]){
            sphere(1, $fn=100);
            rotate([0,0,90*knobRot]){
                union(){
                    //pin
                    translate([0,0,-3*thickness]){
                        cylinder(3,0.52,0.5, $fn=100);
                    }
                    //lock
                    translate([-thickness+0.2,-thickness/4,-3*thickness]){
                            cube([0.5,0.5,0.5]);
                    }
                }
            }
        }}
        
    }}
        
    
}


module innerLid(width,height,depth,thickness,opened){
    translate([thickness,0,-thickness/2]){
    
        rotate([0,-130*opened,0]){
            translate([-thickness,0,thickness/2]){
    
                difference(){
                    translate([0.2,0,-thickness]){
                        difference(){
                            cube([width-thickness/2,depth-thickness,thickness/2]);
                            translate([-thickness/2,thickness*1/2,-0.1]){
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
    }
}


module createDMScreen(){
    screenThickness =2.5;
    screenHeight = 25;

    //Blind
    *translate([10,1,tableHeight-drawerHeight-5]) cube([80,wallThickness,drawerHeight+2.5]);
    
    //Screen
    translate([10,5-40*$t,tableHeight-2.5]){
        difference(){
            //Board
            translate([8,0,0]) difference(){
                cube([64,70,2.5]);
                translate([-14,50,-0.1])rotate([0,0,45]) translate([-5,-25,0])cube([30,40,2.7]);
                translate([45,60,-0.1])rotate([0,0,-45]) translate([0,-10,0])cube([40,40,2.7]);

                translate([-1,5,-0.1])rotate([0,0,45]) translate([-5,-25,0])cube([20,40,2.7]);
                translate([45,5,-0.1])rotate([0,0,-45]) translate([0,-10,0])cube([20,40,2.7]);
            }
            //Left Slid
            translate([10,24,-1])rotate([70,0,25])cube([10,25,screenThickness]);
            
            //Center Slid
            translate([35,32,-1])rotate([70,0,0])cube([10,5,screenThickness]);
            
            //Right Slid
            translate([60,29,-1])rotate([70,0,-25])cube([10,5,screenThickness]);

        }
        //Center Screenpiece
        translate([35,32,-1])rotate([70,0,0])translate([0,3,0])
        union(){
            translate([0,-2,0])cube([10,4,2.4]);
            difference(){
                translate([-10,0,0])cube([30,screenHeight,2.5]);
                translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
            }
        }
        //Left Screenpiece
        translate([10,24,-1])rotate([70,0,25])translate([0,3,0])
        union(){
            translate([0,-2,0])cube([10,4,2.4]);
            difference(){
                translate([-10,0,0])cube([31,screenHeight,2.5]);
                translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
            }
        }
        //Right Screenpiece
        translate([60,29,-1])rotate([70,0,-25])translate([0,3,0])
        union(){
            translate([0,-2,0])cube([10,4,2.4]);
            difference(){
                translate([-10,0,0])cube([31,screenHeight,2.5]);
                translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
            }
        }
    }
}












