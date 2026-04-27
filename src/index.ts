import express, { Request, Response } from "express";
import cors from "cors";
import helmet from "helmet";
import dotenv from "dotenv";

dotenv.config();

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;

app.get("/", (_req: Request, res: Response) => {
  return res.status(200).json({
    message: "Server is running successfully",
    environment: process.env.NODE_ENV || "development",
  });
});

app.get("/health", (_req: Request, res: Response) => {
  return res.status(200).json({
    status: "OK",
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
