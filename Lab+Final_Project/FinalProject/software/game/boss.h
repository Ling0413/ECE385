#ifndef BOSS_H_
#define BOSS_H_

#include "data.h"

void movement_b(
    int state_b[N_state_b],
    long long unsigned int event_b[N1_event_b][N2_event_b],
    int prohibit_b[N_prohibit_b],
    int clock,
    int system_flage[N_system_flage]
);


void update_event_b(
    int state_b[N_state_b],
    int state_c[N_state_c],
    long long unsigned int event_b[N1_event_b][N2_event_b],
    int prohibit_b[N_prohibit_b],
    int clock,
    int system_flage[N_system_flage],
    int cooling_c[N_cooling_c]
);


void change_event_b(
    int state_b[N_state_b],
    int state_c[N_state_c],
    long long unsigned int event_b[N1_event_b][N2_event_b],
    int prohibit_b[N_prohibit_b],
    int clock,
    int system_flage[N_system_flage],
    int cooling_c[N_cooling_c]
);


#endif