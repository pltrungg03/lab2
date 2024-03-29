<%-- 
    Document   : transaction-header
    Created on : Oct 14, 2023, 11:19:46 AM
    Author     : ADMIN
--%>
<style>
    /* CSS */
    .button-27 {
        appearance: none;
        background-color: #000000;
        border: 2px solid #1A1A1A;
        border-radius: 15px;
        box-sizing: border-box;
        color: white;
        cursor: pointer;
        display: inline-block;
        font-family: Roobert,-apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";
        font-size: 16px;
        font-weight: 600;
        line-height: normal;
        margin: 0;
        min-height: 60px;
        min-width: 0;
        outline: none;
        padding: 16px 24px;
        text-align: center;
        text-decoration: none;
        transition: all 300ms cubic-bezier(.23, 1, 0.32, 1);
        user-select: none;
        -webkit-user-select: none;
        touch-action: manipulation;
        width: 200px;
        will-change: transform;
        
    }

    .button-27:disabled {
        pointer-events: none;
    }

    .button-27:hover {
        box-shadow: rgba(0, 0, 0, 0.25) 0 8px 15px;
        transform: translateY(-2px);
    }

    .button-27:active {
        box-shadow: none;
        transform: translateY(0);
    }
</style>

<div style="display: flex; justify-content: space-around; margin-bottom: 20px ;">
    <div >
        <button class="button-27" role="button"><a style="color: white" href="charge-wallet">Charge</a></button>
    </div>
    <div>
        <button class="button-27" role="button"><a style="color: white" href="charge-transaction">Charge History</a></button>
    </div>
    <div>
        <button class="button-27" role="button"><a  style="color: white" href="usage-transaction">Usage History</a></button>
    </div>
    <div>
        <button class="button-27" role="button"><a  style="color: white" href="upgrade-premium">Upgrade Premium</a></button>
    </div>
</div>
