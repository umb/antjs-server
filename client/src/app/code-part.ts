export class CodePart {
    public code: string;
    public label: string;
    public parameters: string[];
    public methodName: string;

    constructor(methodName: string, code: string, label: string, parameters: string[]) {
        this.methodName = methodName;
        this.code = code;
        this.label = label;
        this.parameters = parameters;
    }
}