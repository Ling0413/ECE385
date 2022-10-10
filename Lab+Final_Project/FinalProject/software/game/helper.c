/*
    Helper functions.
*/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include "helper.h"




// Initializing hardware interface and software parameters
// Noting that event vector should reset seperately
void initial(
    long long unsigned int * spirit, 
    int * state_c, 
    int * state_b,
    long long unsigned int event_c[N1_event_c][N2_event_c],
    long long unsigned int event_b[N1_event_c][N2_event_c],
    long long unsigned int event_s[N1_event_c][N2_event_c],
    int prohibit_c[N_prohibit_c],
    int prohibit_b[N_prohibit_b],
    int cooling_c[N_cooling_c],
    int system_flage[N_system_flage]
)
{
    // Initializing event
    clean_event(event_c);
    set_event(event_c, event_c_stand);
    set_prohibition(prohibit_c, event_c[0][pvector]);
    state_c[Offx] = event_c[1][2];
    state_c[Offy] = event_c[1][3];
    state_c[CenOffx] = event_c[1][4];
    state_c[CenOffy] = event_c[1][5];

    clean_event(event_b);
    set_event(event_b, event_b_stand);
    set_prohibition(prohibit_b, event_b[0][pvector]);
    state_b[Offx] = event_b[1][2];
    state_b[Offy] = event_b[1][3];
    state_b[CenOffx] = event_b[1][4];
    state_b[CenOffy] = event_b[1][5];

    clean_event(event_s);

    spirit[15] = 0x00000040b812ec00;
    for (int i = 0; i < 15; i++) {
        spirit[i] = 0x0;
    }

    // Initializing state
    for (int i = 0; i < N_state_c; i++){
        state_c[i] = 0;
    }
    state_c[Cx] = 200;
    state_c[Cy] = 358;
    state_c[Ori] = 1;
    state_c[Cenx] = state_c[Cx] + state_c[CenOffx];
    state_c[Ceny] = state_c[Cy] + state_c[CenOffy];
    state_c[Health] = 8;

    for (int i = 0; i < N_state_b; i++){
        state_b[i] = 0;
    }
    state_b[Cx] = 400;
    state_b[Cy] = 250;
    state_b[Ori] = 0;
    state_b[Cenx] = state_b[Cx] + state_b[CenOffx];
    state_b[Ceny] = state_b[Cy] + state_b[CenOffy];
    state_b[skill] = 1;
    state_b[Health] = 30;

    // Initializing system_flages and cooling list
    for (int i = 0; i < N_cooling_c; i++) {
        cooling_c[i] = 0;
        system_flage[i] = 0;
    }
    cooling_c[c_stiff] = 120;
}


// Write spirits into interface
void write_spirit(
    long long unsigned int * spirit,
    unsigned int * data
)
{
    // Wait untile write enable signal becomes high
    while ((GameControl_PTR[60] & 0x2) == 0) {}
    *data = GameControl_PTR[60];
    // Write spirits to hardware interface
    for (int i = 0; i < 16; i++) {
        // GameControl_PTR[4*i] = spirit[i][0];			// [31:0]
        // GameControl_PTR[4*i+1] = spirit[i][0] >> 32;	// [63:23]
        GameControl_PTR[4*i+2] = spirit[i];			// [95:64]
        GameControl_PTR[4*i+3] = spirit[i] >> 32;	// [127:96]
    }
}


// Set the coordinate of i-th spirit to (x,y)
void set_state(
    int x,
    int y,
    int ori,
    long long unsigned int * spirit, 
    int i
)
{
	long long unsigned int copy;
	long long unsigned int temp = 0x0;
	unsigned int xm, ym;

    if (ori == 0) {
        copy = spirit[i] & 0xfefffffffff00000; 	// maked by 0xffff ffff fff0 0000, i.e. set the [19:0] to 0
    } else {
        copy = spirit[i] & 0xfffffffffff00000;
        copy = copy | 0x0100000000000000;
    }

	xm = x & 0x03ff;
	ym = y & 0x03ff;
	temp = (temp + xm) << 10;
	temp = (temp + ym);
	spirit[i] = copy | temp;
}


// Set the address and offset information of i-th spirit
void set_address(
    long long unsigned int data, 
    long long unsigned int * spirit, 
    int i
)
{
    spirit[i] = (spirit[i] & 0xff000000000fffff) | data;    // Reset [55:20] while preserving other data
}


// Set Prohibition list
void set_prohibition(
    int prohibit[N_prohibit_c],
    unsigned int p_vector
)
{
    unsigned int mask = 0x0001;
    for (int i = 0; i < N_prohibit_c; i++) {
        if ((mask & p_vector) != 0) {
            prohibit[i] = 1;
        }
        mask = mask << 1;
    }
}


// Free Prohibition list
void free_prohibition(
    int prohibit[N_prohibit_c],
    unsigned int p_vector
)
{
    unsigned int mask = 0x0001;
    for (int i = 0; i < N_prohibit_c; i++) {
        if ((mask & p_vector) != 0) {
            prohibit[i] = 0;
        }
        mask = mask << 1;
    }
}


// Set the event list
void set_event(
    long long unsigned int event_list[N1_event_c][N2_event_c],
    long long unsigned int event[N1_event_c][N2_event_c]
)
{
    int size = event[0][fnum];
    for (int i = 0; i <= size; i++) {
        for (int j = 0; j < N2_event_c; j++) {
            event_list[i][j] = event[i][j];
        }
    }
}


// Clean the event list
void clean_event(
    long long unsigned int event_list[N1_event_c][N2_event_c]
)
{
    for (int i = 0; i < N1_event_c; i++) {
        for (int j = 0; j < N2_event_c; j++) {
            event_list[i][j] = 0x0;
        }
    }
}
