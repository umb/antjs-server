import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment';

import { Observable } from 'rxjs/internal/Observable';
import { Player } from './player';


@Injectable()
export class PlayerService {

    constructor(private http: HttpClient) {
    }

    public createPlayer(player: Player) : Observable<Player>{
        const playerUrl = `${environment.serverURL}/players/`;

        return this.http.post<Player>(playerUrl, player);
    }

    public loadPlayer(playerId: string) : Observable<Player>{
        const playerUrl = `${environment.serverURL}/players/${playerId}`;

        return this.http.get<Player>(playerUrl);
    }

}