import { Component } from '@angular/core';
import { CodeUploadService } from './code-upload.service';
import { Code } from './code';
import { Player } from './player';
import { PlayerService } from './player.service';
import { GameService } from './game.service';
import { catchError, flatMap, takeUntil } from 'rxjs/operators';
import { Game } from './game';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent {
    public static playerIdStorageKey: string = 'playerId';
    public static codeStorageKey: string = 'code';
    public static readyToPlayText: string = 'Ready To Play';
    public static waitingForPlayersText: string = 'WaitingForOtherPlayers';
    public code: Code = new Code();
    public desiredPlayerName: string;
    public player: Player;
    public loadingPlayerFinished: boolean;
    public unsafedChanges: boolean;
    public readyToPlayBtnText: string = AppComponent.readyToPlayText;
    public waitingForPlayers: boolean;
    private currentGameId: number;
    public lastGame: Game;

    constructor(private playerService: PlayerService, private codeUploadService: CodeUploadService, private gameService: GameService) {
        this.loadPlayer();

        const codeFromStorage = localStorage.getItem(AppComponent.codeStorageKey);

        if (codeFromStorage) {
            this.code = Object.assign(this.code, JSON.parse(codeFromStorage));
        }

    }

    private loadPlayer(): void {
        const playerId = localStorage.getItem(AppComponent.playerIdStorageKey);

        if (playerId) {
            this.playerService.loadPlayer(playerId).subscribe((player) => {
                this.player = player;
                this.loadingPlayerFinished = true;
            }, err => this.logout());
        } else {
            this.loadingPlayerFinished = true;
        }
    }

    public uploadCode(): void {
        console.log(this.code.toModuleString());
        localStorage.setItem(AppComponent.codeStorageKey, JSON.stringify(this.code));
        this.codeUploadService.uploadCode(this.code, this.player.id).subscribe(() => this.unsafedChanges = false);
    }

    public savePlayer() {
        const player = new Player();
        player.name = this.desiredPlayerName;
        this.playerService.createPlayer(player).subscribe(player => {
            localStorage.setItem(AppComponent.playerIdStorageKey, player.id);
            this.player = player;
        });
    }

    public readyToPlay() {
        this.readyToPlayBtnText = AppComponent.waitingForPlayersText;
        this.waitingForPlayers = true;
        this.startGame();
    }

    public onCodeChange() {
        this.unsafedChanges = true;
    }

    public startGame() {
        this.lastGame = null;

        this.gameService.startGame({}).subscribe(game => {
            this.currentGameId = game.id;

            // interval(5000).pipe(
            //     takeUntil(Observable.create(this.lastGame && this.lastGame.frames)),
            //     flatMap(s => this.gameService.loadGame(this.currentGameId))
            // ).subscribe(game => {
            //     if (game.frames && game.frames.length) {
            //         this.lastGame = game;
            //     }
            // });

            this.gameService.loadGame(this.currentGameId).subscribe(game => {
                if (game.frames && game.frames.length) {
                    this.lastGame = game;
                }
            });
        });
    }

    public logout() {
        localStorage.removeItem(AppComponent.playerIdStorageKey);
        localStorage.removeItem(AppComponent.codeStorageKey);
        this.player = null;
        this.code = new Code();
        this.lastGame = null;
        this.currentGameId = null;
    }
}
