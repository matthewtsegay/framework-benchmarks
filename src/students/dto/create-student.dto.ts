import { IsEmail, IsInt, IsNotEmpty, IsString, Min } from 'class-validator';

export class CreateStudentDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsInt()
    @Min(0)
    age: number;

    @IsEmail()
    email: string;
}
