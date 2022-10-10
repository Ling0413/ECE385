#ifndef hepler_h_
#define hepler_h_

#include "data.h"

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
);


void write_spirit(
    long long unsigned int * spirit,
    unsigned int * data
);


void set_state(
    int x,
    int y,
    int ori,
    long long unsigned int * spirit, 
    int i
);


void set_address(
    long long unsigned int data, 
    long long unsigned int * spirit, 
    int i
);


void set_prohibition(
    int prohibit[N_prohibit_c],
    unsigned int p_vector
);


void free_prohibition(
    int prohibit[N_prohibit_c],
    unsigned int p_vector
);


void set_event(
    long long unsigned int event_list[N1_event_c][N2_event_c],
    long long unsigned int event[N1_event_c][N2_event_c]
);


void clean_event(
    long long unsigned int event_list[N1_event_c][N2_event_c]
);


#endif