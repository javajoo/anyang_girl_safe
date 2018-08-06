package com.danusys.exception;

/*
//  클래스  명 : BaseException
//  클래스설명 : BaseException 클래스
*/
public class BaseException
{
    public static String EXCEPTION_MESSAGE = "";


    /**
     * FuncName : printStackTraceToString
     * FuncDesc : Exception Message 반환
     * Param    : e : Exception
     * Return   : String : Exception Message String
    */
    public static String printStackTraceToString(Throwable e)
    {
        StringBuilder sb = new StringBuilder();

        sb.append(e.toString());
        sb.append("\n");

        StackTraceElement element[] = e.getStackTrace();

        for (int i=0; i<element.length; i++)
        {
            sb.append("\tat ");
            sb.append(element[i].toString());
            sb.append("\n");
        }

        EXCEPTION_MESSAGE = sb.toString();

        return sb.toString();
    }
}
