import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment';
import { Code } from './code';
import { Observable } from 'rxjs/internal/Observable';

@Injectable()
export class CodeUploadService {

    constructor(private http: HttpClient) {
    }


    public uploadCode(code: Code, playerId: string) : Observable<string>{
        const codeUploadUrl = `${environment.serverURL}/players/${playerId}/code_uploads`;

        return this.http.post<string>(codeUploadUrl, {code: code.toModuleString()})
    }

}