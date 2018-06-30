import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment';

import { Observable } from 'rxjs/internal/Observable';
import { Game } from './game';




@Injectable()
export class GameService {

    constructor(private http: HttpClient) {
    }

    public startGame(game: Game) : Observable<Game>{
        const gameUrl = `${environment.serverURL}/games/`;

        return this.http.post<Game>(gameUrl, game);
    }

    public loadGame(gameId: number) : Observable<Game>{
        const playerUrl = `${environment.serverURL}/games/${gameId}`;

        return this.http.get<Game>(playerUrl);
    }

}