import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CodeUploadService } from './code-upload.service';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { PlayerService } from './player.service';
import { GameService } from './game.service';

@NgModule({
    declarations: [
        AppComponent
    ],
    imports: [
        BrowserModule,
        FormsModule,
        CommonModule,
        HttpClientModule
    ],
    providers: [CodeUploadService, HttpClient, PlayerService, GameService],
    bootstrap: [AppComponent]
})
export class AppModule {
}
