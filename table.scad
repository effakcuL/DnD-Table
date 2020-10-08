drawerHeight = 3;
drawerWidth = 40;
drawerDepth = 10;
drawerOverlap = 13;
drawerOffset = -8;
wallThickness = 1;
maxStep = 9;
tableHeight = 80;
footLength = 70;
toeLength = 20;
toeWidth = 60;
toeAngle = 70;

surfaceAngle=65;
surfaceWidth= 180;
surfaceDepth=110;

tvDepth=7;



sideLength = surfaceWidth/(1+2*sin(surfaceAngle));
c = sin(surfaceAngle) * sideLength;
d = cos(surfaceAngle) * sideLength;
dmWidth = surfaceDepth-2*d;

footIntersection = c + tan(90-surfaceAngle)*surfaceDepth/2;
echo(footIntersection);



translate([-100,-50,-10])color("gray")cube([300,300,10]);

translate([0,0,tableHeight-drawerHeight-tvDepth]) rotate([0,0,180]) {
    translate([0,-c,0]) rotate([0,0,90-surfaceAngle]){
        translate([-3+drawerOffset,0,0])cube([3,sideLength,drawerHeight+3]);
        translate([-(drawerDepth+drawerOverlap-drawerOffset),sideLength/2-drawerWidth/2,0])
            createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
    translate([-(drawerDepth+drawerOverlap),-(c+sideLength)+sideLength/2-drawerWidth/2,0]){
        translate([-3+drawerDepth+drawerOverlap+drawerOffset,-sideLength/2+drawerWidth/2,0])cube([3,sideLength,drawerHeight+3]);
        translate([drawerOffset,0,0])
        createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
    translate([0,-c-sideLength,0]) rotate([0,0,surfaceAngle-90]){


        translate([-3+drawerOffset,-sideLength,0])cube([3,sideLength,drawerHeight+3]);
        translate([-(drawerDepth+drawerOverlap-drawerOffset),-sideLength+sideLength/2-drawerWidth/2,0])
            createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
}


translate([surfaceDepth,surfaceWidth,tableHeight-drawerHeight-tvDepth]){
    translate([0,-c,0]) rotate([0,0,90-surfaceAngle]){
        translate([-3+drawerOffset,0,0])cube([3,sideLength,drawerHeight+3]);
        translate([-(drawerDepth+drawerOverlap-drawerOffset),sideLength/2-drawerWidth/2,0])
            createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
    translate([-(drawerDepth+drawerOverlap-drawerOffset),-(c+sideLength)+sideLength/2-drawerWidth/2,0]){
        translate([-3+drawerDepth+drawerOverlap,-sideLength/2+drawerWidth/2,0])cube([3,sideLength,drawerHeight+3]);
        createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
    translate([0,-c-sideLength,0]) rotate([0,0,surfaceAngle-90]){
        translate([-3+drawerOffset,-sideLength,-0.2])cube([3,sideLength,drawerHeight+3]);
        translate([-(drawerDepth+drawerOverlap-drawerOffset),-sideLength+sideLength/2-drawerWidth/2,0])
            color("green")
            createDrawer(drawerDepth,drawerHeight,drawerWidth,wallThickness,drawerOverlap);
    }
}




*createDMScreen2();
translate([surfaceDepth,surfaceWidth,0])rotate([0,0,180]) createDMScreen2();
tableTop();


//Regular Legs

*cube([10,10,100]);
*translate([10,110,0])rotate([0,5,0])cube([5,10,tableHeight-5]);
*translate([10,110,0])rotate([0,0,0])cube([80,10,5]);
*translate([90,110,0])rotate([0,-5,0])cube([5,10,tableHeight-5]);

legHeight = tableHeight-tvDepth-drawerHeight-3;
wholeLegWidth = 0.8*surfaceWidth;
wholeLegBreadth = 0.8*surfaceDepth;
legAngle = 45;
legWidth = 10;
legPieceLength= (legHeight/2+ cos(90-legAngle)*legWidth ) /cos(legAngle);
legPieceWidth= (legHeight/2+ sin(90-legAngle)*legWidth ) /tan(legAngle);

translate([55,45,0])rotate([0,0,180]){
    chevron();
    translate([-30,-20,0])rotate([0,0,65])chevron();
    translate([32.5,-15,0])rotate([0,0,-65])chevron();
    translate([-7.5,-45,18])cube([20,20,28]);
}

translate([50,135,0]){
    chevron();
    translate([-30,-20,0])rotate([0,0,65])chevron();
    translate([32.5,-15,0])rotate([0,0,-65])chevron();
    translate([-7.5,-45,18])
    difference(){
        cube([20,20,28]);
        rotate([0,0,65])translate([0,6,0])cube([300,100,30]);
        rotate([0,0,115])translate([0,0,0])cube([300,100,50]);

    }
}
module chevronPiece(){
    chevronThickness = 5;
    chevronWidth = 10;
    chevronHeight = 70;
    chevronAngle = 45;
    difference(){
    translate([0,0, - chevronWidth * cos(90 - chevronAngle)]) rotate([chevronAngle,0,0]) cube([chevronThickness,chevronWidth, (chevronHeight/2) / sin(90-chevronAngle)]);
    translate([-2,-10,-10])
    cube([10,20,10]);
    translate([-2,-40,32])
    cube([10,20,10]);
    translate([4,-45,15])
    cube([3,20,20]);
    translate([-2,-45,15])
    cube([3,20,20]);
    translate([-2,-45,10])
    cube([10,20,13]);
    translate([-2,-50,15])
    cube([10,20,20]);       
    }
    
}

module chevron(){
chevronPiece();
translate([5,0,64])rotate([0,180,0])
chevronPiece();
}




module tableTop(){
    tableWidth = surfaceWidth;
    tableDepth = surfaceDepth;
    angle = 65;
    translate([10,10,tableHeight-15]){
              color("green")      octagon(tableWidth-20,tableDepth-20,15,angle);

    };
    translate([0,0,tableHeight+3]){  
        *difference(){
            octagon(tableWidth,tableDepth,1.5,angle);
            translate([5,10,-0.1]) color("green") octagon(tableWidth-20,tableDepth-10,1.5,angle);
        }

        difference(){
            translate([0,0,-3])octagon(tableWidth,tableDepth,1.5,angle);
            #translate([20,40,-7.5])cube([59,99,8]);
            //#translate([20,30,-7.5])cube([69,116,8]);

        }
        #translate([20,40,-9])cube([59,99,7.5]);


        //#translate([26,40,-7.5])cube([48,80,8]);

    }
}

module octagon(width,depth,height,angle){
    sideLength = width/(1+2*sin(angle));
    c = sin(angle) * sideLength;
    difference(){
        cube([depth,width,height]);
        translate([0,c,-1])rotate([0,0,-angle])translate([0,-40,0])cube([sideLength,40,height+2]);
        translate([0,width-c,-1])rotate([0,0,angle])translate([0,0,0])cube([sideLength,40,height+2]);

        translate([depth,c,-1])rotate([0,0,180+angle])translate([0,0,0])cube([sideLength,40,height+2]);
        translate([depth,width-c,-1])rotate([0,0,180-angle])translate([0,-40,0])cube([sideLength,40,height+2]);
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
                }else if($t < 6/maxStep){ //both lids closed
                    color("green") outerLid(width,height,depth,thickness,0);
                    color("yellow") innerLid(width,height,depth,thickness,0);
                }else if($t < 7/maxStep){ //open both lids
                    color("green") outerLid(width,height,depth,thickness, ($t-6/maxStep)*maxStep);
                    color("yellow") innerLid(width,height,depth,thickness,($t-6/maxStep)*maxStep);
                }else if($t < 8/maxStep){ //turn knob
                    color("green") outerLid(width,height,depth,thickness,1,($t-7/maxStep)*maxStep);
                    color("yellow") innerLid(width,height,depth,thickness,1);
                }else if($t < 9/maxStep){ //close inner lid
                    color("green") outerLid(width,height,depth,thickness,1,1);
                    color("yellow") innerLid(width,height,depth,thickness,1-($t-8/maxStep)*maxStep);
                }else if($t < 10/maxStep){
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
        rotate([0,-110*opened,0]){
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

        rotate([0,-110*opened,0]){
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








module createDMScreen2(){


    screenThickness =2.5;
    screenHeight = 25;

    //Blind
    translate([d,0,tableHeight-drawerHeight-5.5]) cube([dmWidth,wallThickness,drawerHeight+3]);

    //Screen
    translate([0,0,tableHeight-2.5])

        if($t<5/maxStep){
            createPullout(screenThickness,screenHeight);
        }else{

            translate([0,-40*min(($t-5/maxStep)*maxStep,1),0]){
                createPullout(screenThickness,screenHeight);
            }
        }
}
module createPullout2(screenThickness,screenHeight){
    difference(){
        //Board


        *translate([0,0,0]) difference(){
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
    if($t > 7/maxStep){
        time = min(($t-7/maxStep)*maxStep,1);
        //Center Screenpiece
        translate([35,32,-1])rotate([70,0,0])translate([0,3+20-20*time,0])
            union(){
                translate([0,-2,0])cube([10,4,2.4]);
                difference(){
                    translate([-10,0,0])cube([30,screenHeight,2.5]);
                    translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
                }
            }
        //Left Screenpiece
        translate([10,24,-1])rotate([70,0,25])translate([0,3+20-20*time,0])
            union(){
                translate([0,-2,0])cube([10,4,2.4]);
                difference(){
                    translate([-10,0,0])cube([31,screenHeight,2.5]);
                    translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
                }
            }
        //Right Screenpiece
        translate([60,29,-1])rotate([70,0,-25])translate([0,3+20-20*time,0])
            union(){
                translate([0,-2,0])cube([10,4,2.4]);
                difference(){
                    translate([-10,0,0])cube([31,screenHeight,2.5]);
                    translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
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
    translate([0,0,tableHeight-2.5])

        if($t<5/maxStep){
            createPullout(screenThickness,screenHeight);
        }else{

            translate([0,-40*min(($t-5/maxStep)*maxStep,1),0]){
                createPullout(screenThickness,screenHeight);
            }
        }
}





module createPullout(screenThickness,screenHeight){
    difference(){
        echo(sin(surfaceAngle));
        pullOutLength=40;
        translate([d,0,0]){
            union(){
                rotate([0,0,-surfaceAngle])translate([-sin(surfaceAngle)*pullOutLength,0,0])
                    cube([sin(surfaceAngle)*pullOutLength,20,2.5]);

                cube([dmWidth,40,2.5]);

                translate([dmWidth,0,0])rotate([0,0,surfaceAngle])
                    cube([sin(surfaceAngle)*pullOutLength,20,2.5]);
            }
        }
        translate([d-15,0,0]){

            //Left Slid
            translate([10,24,-1])rotate([70,0,25])cube([10,25,screenThickness]);

            //Center Slid
            translate([35,32,-1])rotate([70,0,0])cube([10,5,screenThickness]);

            //Right Slid
            translate([60,29,-1])rotate([70,0,-25])cube([10,5,screenThickness]);
        }
    }
    translate([d-15,0,0]){
        if($t > 7/maxStep){
            time = min(($t-7/maxStep)*maxStep,1);
            //Center Screenpiece
            translate([35,32,-1])rotate([70,0,0])translate([0,3+20-20*time,0])
                union(){
                    translate([0,-2,0])cube([10,4,2.4]);
                    difference(){
                        translate([-10,0,0])cube([30,screenHeight,2.5]);
                        translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
                    }
                }
            //Left Screenpiece
            translate([10,24,-1])rotate([70,0,25])translate([0,3+20-20*time,0])
                union(){
                    translate([0,-2,0])cube([10,4,2.4]);
                    difference(){
                        translate([-10,0,0])cube([31,screenHeight,2.5]);
                        translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
                    }
                }
            //Right Screenpiece
            translate([60,29,-1])rotate([70,0,-25])translate([0,3+20-20*time,0])
                union(){
                    translate([0,-2,0])cube([10,4,2.4]);
                    difference(){
                        translate([-10,0,0])cube([31,screenHeight,2.5]);
                        translate([-10,0,0])rotate([20,0,0])translate([0,0,-1]) cube([32,1,10]);
                    }
                }}
    }
}











