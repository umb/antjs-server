import { Component } from '@angular/core';
import { CodeUploadService } from './code-upload.service';
import { Code } from './code';
import { Player } from './player';
import { PlayerService } from './player.service';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent {
    public static playerIdStorageKey: string = 'playerId';
    public code: Code = new Code();
    public desiredPlayerName: string;
    public player: Player;
    public loadingPlayerFinished: boolean;

    constructor(private playerService: PlayerService, private codeUploadService: CodeUploadService) {
        this.loadPlayer();
    }

    private loadPlayer(): void {
        const playerId = localStorage.getItem(AppComponent.playerIdStorageKey);

        if (playerId) {
            this.playerService.loadPlayer(playerId).subscribe((player) => {
                this.player = player;
                this.loadingPlayerFinished = true;
            });
        } else {
            this.loadingPlayerFinished = true;
        }
    }

    public uploadCode(): void {
        console.log(this.code.toModuleString());
        this.codeUploadService.uploadCode(this.code, this.player.id).subscribe(() => alert('uploaded'));
    }

    public savePlayer() {
        const player = new Player();
        player.name = this.desiredPlayerName;
        this.playerService.createPlayer(player).subscribe(player => {
            localStorage.setItem(AppComponent.playerIdStorageKey, player.id);
            this.player = player;
        });
    }

    public logout() {
        localStorage.removeItem(AppComponent.playerIdStorageKey);
        this.player = null;
    }
}
